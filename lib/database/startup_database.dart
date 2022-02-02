import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StartupDataBase {
  final FirebaseAuth? auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  void addUserName(String name) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"userName": name});
  }

  void addStartupName(String name) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupName": name});
  }

  void addRegStartupName(String name) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"regStartupName": name});
  }

  void addWebAppUrl(String url) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"webAppUrl": url});
  }

  void addLinkedinUrl(String url) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"linkedinUrl": url});
  }

  void addFounderInfo(String reply, String secondFounderName,
      String secondFounderEmail, String secondFounderLinkedinUrl) async {
    print("reply value");
    print(reply);
    if (reply == "Yes") {
      await firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"singleUser": "Yes"});
    } else {
      await firestore.collection("Startups").doc(user!.uid).update({
        "singleUser": "No",
        "secondFounderName": secondFounderName,
        "secondFounderEmail": secondFounderEmail,
        "secondFounderLinkedinUrl": secondFounderLinkedinUrl
      });
    }
  }

  void addStartupCategory(String category) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupCategory": category});
  }

  void addStartupDescription(String description) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupDescription": description});
  }

  void addStartupCityName(String city) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupCity": city});
  }

  void addStartupStage(String stage) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupStage": stage});
  }

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  void addPitchDeckUrl(String url) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"pitchDeckUrl": url});
  }

  uploadUserImages(File userImages, String folderTitle) async {
    if (userImages.path != '') {
      final ref = FirebaseStorage.instance
          .ref()
          .child('startup_img')
          .child(folderTitle)
          .child(user!.uid + folderTitle + '.jpg');

      await ref.putFile(userImages).whenComplete(() => print('Image Upload'));

      String url = await ref.getDownloadURL();
      print("This is uploaded img url: $url");
      print("_________________________");
      if (folderTitle == "startupLogo") {
        await firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"startupLogoUrl": url});
      } else if (folderTitle == "Founder") {
        await firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"founderImg": url});
      } else if (folderTitle == "Co-Founder") {
        await firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"coFounderImg": url});
      }
    }
  }

  ///Add investor to exclude list
  void addInvestorToExcludeList(String otherUid, bool fromInvite) async {
    List<String> uidList = [];
    uidList.add(otherUid);
    try {
      await firestore.collection("Startups").doc(user!.uid).update({
        "excludeInvestor": FieldValue.arrayUnion(uidList),
      });

      if (fromInvite) {
        List<String> myUidList = [];
        myUidList.add(user!.uid);
        await firestore
            .collection("Investors")
            .doc(otherUid)
            .update({"excludeStartup": FieldValue.arrayUnion(myUidList)});
      }
    } catch (e) {
      print(e);
    }
  }

  ///Add Investor to request
  void addInviteMethod(
    String startupUserName,
    String startupImgUrl,
    String startupUid,
    String investorName,
    String investorImgUrl,
    String investorUid,
  ) async {
    DateTime time = DateTime.now();

    List<dynamic> myInviteList = [];
    List<dynamic> otherInviteList = [];

    await firestore.collection("Startups").doc(user!.uid).get().then((val) {
      myInviteList = val.data()!['inviteList'];
    });
    await firestore.collection("Investors").doc(investorUid).get().then((val) {
      otherInviteList = val.data()!['inviteList'];
    });

    List<Map<String, dynamic>> myMap = [
      {
        "time": time,
        "recieved": "",
        "sent": investorName,
        "image": investorImgUrl,
        "id": investorUid
      }
    ];

    List<Map<String, dynamic>> otherMap = [
      {
        "time": time,
        "recieved": startupUserName,
        "sent": "",
        "image": startupImgUrl,
        "id": startupUid
      }
    ];

    await firestore.collection("Startups").doc(user!.uid).update({
      'inviteList': FieldValue.arrayUnion(myMap),
      'latestConnectionSentUid': investorUid,
    });

    await firestore
        .collection("Investors")
        .doc(investorUid)
        .update({'inviteList': FieldValue.arrayUnion(otherMap)});
  }

  ///Remove Investor from pending list
  void removeInvestorFromPending(String investorUid) async {
    try {
      await firestore.collection("Startups").doc(user!.uid).get().then((value) {
        Map<String, dynamic> myMap = value.data()!;
        List<dynamic> inviteList = myMap['inviteList'];
        inviteList.removeWhere((element) => element['id'] == investorUid);

        firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"inviteList": inviteList});
      });

      await firestore
          .collection("Investors")
          .doc(investorUid)
          .get()
          .then((value) {
        Map<String, dynamic> myMap = value.data()!;
        List<dynamic> inviteList = myMap['inviteList'];
        inviteList.removeWhere((element) => element['id'] == user!.uid);

        firestore
            .collection("Investors")
            .doc(investorUid)
            .update({"inviteList": inviteList});
      });
    } catch (e) {
      print(e);
    }
  }

  ///Accept offer of investor
  void acceptOffer(String startupName, String startupLogo, String investorName,
      String investorImg, String investorUid) async {
    DateTime time = DateTime.now();

    List<Map<String, dynamic>> myMatchMap = [
      {
        "friendname": investorName,
        "friendImage": investorImg,
        "friendUid": investorUid
      }
    ];

    List<Map<String, dynamic>> otherMatchMap = [
      {
        "friendname": startupName,
        "friendImage": startupLogo,
        "friendUid": user!.uid
      }
    ];

    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({'matchUsers': FieldValue.arrayUnion(myMatchMap)});

      firestore
          .collection("Investors")
          .doc(investorUid)
          .update({'matchUsers': FieldValue.arrayUnion(otherMatchMap)});
    } catch (e) {
      print(e.toString());
    }
  }

  addMessageMethod(
    String workStreamId,
    String messageId,
    Map<String, dynamic> messageInfo,
  ) async {
    try {
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("chats")
          .doc(messageId)
          .set(messageInfo);
    } catch (e) {
      print(e.toString());
    }
  }

  updateLastMessageSend(
      String workStreamId, Map<String, dynamic> lastMessageInfoMap) {
    try {
      return firestore
          .collection("workstream")
          .doc(workStreamId)
          .update(lastMessageInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  ///Create workstream if not exists.
  createWorkstream(String workStreamId, workStreamMap) async {
    try {
      final snapshot =
          await firestore.collection("workstream").doc(workStreamId).get();

      //work stream Exists.
      if (snapshot.exists) {
        return true;
      }

      //workstream doesn't exists so create workstream.
      else {
        return firestore
            .collection("workstream")
            .doc(workStreamId)
            .set(workStreamMap)
            .catchError((e) {
          print(e.toString());
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
