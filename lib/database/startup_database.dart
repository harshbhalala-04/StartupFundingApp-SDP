// ignore_for_file: unused_element

import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';

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

  void addProofUrl(String url, String workStreamId, String stageUid) async {
    Map<String, dynamic> tmpMap = {};

    await firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageUid)
        .get()
        .then((val) {
      tmpMap = val.data()!['proof_of_work'];
      tmpMap['proofUrl'] = url;
    });
    await firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageUid)
        .update(tmpMap);
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

  uploadProofImages(List<File> uploadImages, String folderTitle,
      String stageUid, String workStreamId) async {
    List<String> urlList = [];
    for (int i = 0; i < uploadImages.length; i++) {
      if (uploadImages[i].path != '') {
        final ref = FirebaseStorage.instance
            .ref()
            .child('proof_of_work')
            .child(folderTitle)
            .child(user!.uid + folderTitle + '.jpg');

        await ref
            .putFile(uploadImages[i])
            .whenComplete(() => print('Image Upload'));

        String url = await ref.getDownloadURL();
        urlList.add(url);
      }
    }
    await firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageUid)
        .update({
      "proof_of_work": {"photos": FieldValue.arrayUnion(urlList)},
      "uploadedProofImg": true,
    });
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

  ///Get message of whole workstream
  getWorkStreamMessages(workStreamId) async {
    try {
      return firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("chats")
          .orderBy("ts", descending: true)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  void addStageDetails(
      Map<String, dynamic> stage, String workStreamId, String stageIndex) {
    stage['createdAt'] = Timestamp.now();
    stage['stageUid'] = "stage " + stageIndex;

    try {
      firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("stages")
          .doc("stage " + stageIndex)
          .set(stage);

      if (stageIndex == "1") {
        firestore
            .collection("workstream")
            .doc(workStreamId)
            .update({"stageCreated": true});
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void editStageDetails(Map<String, dynamic> stage, int index,
      String stageIndex, String workStreamId) async {
    try {
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("stages")
          .doc("stage " + stageIndex)
          .update(stage);

      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("stages")
          .doc("stage " + stageIndex)
          .get()
          .then((value) {
        if (value.data()!.containsKey("approveStage")) {
          firestore
              .collection("workstream")
              .doc(workStreamId)
              .collection("stages")
              .doc("stage " + stageIndex)
              .update({"approveStage": FieldValue.delete()});
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void submitStage(String workStreamId) {
    Get.find<CreateEditStageController>().isStageSubmitted.value = true;
    try {
      firestore
          .collection("workstream")
          .doc(workStreamId)
          .update({"submitStage": true, "verifiedStage": false});

      firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("status")
          .doc()
          .set({
        "timestamp": Timestamp.now(),
        "statusDes": "Stages have been submitted"
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupName(String startupName) {
    Get.find<StartupGlobalController>().currentStartup.startupName =
        startupName;
    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"startupName": startupName});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupFounderImg(String founderImg) {
    Get.find<StartupGlobalController>().currentStartup.founderImg = founderImg;
    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"founderImg": founderImg});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupRegisteredName(String regStartupName) {
    Get.find<StartupGlobalController>().currentStartup.regStartupName =
        regStartupName;
    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"regStartupName": regStartupName});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupPhoneNo(String phoneNo) {
    Get.find<StartupGlobalController>().currentStartup.phoneNo = phoneNo;
    firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"phoneNo": phoneNo});
  }

  void updateStartupLogoUrl(String startupLogoUrl) {
    Get.find<StartupGlobalController>().currentStartup.startupLogoUrl =
        startupLogoUrl;
    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"startupLogoUrl": startupLogoUrl});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupUserName(String userName) {
    Get.find<StartupGlobalController>().currentStartup.userName = userName;
    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"userName": userName});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupEmail(String email) {
    Get.find<StartupGlobalController>().currentStartup.email = email;
    try {
      firestore.collection("Startups").doc(user!.uid).update({"email": email});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupLinkedinUrl(String linkedinUrl) {
    Get.find<StartupGlobalController>().currentStartup.linkedinUrl =
        linkedinUrl;

    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"linkedinUrl": linkedinUrl});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupCity(String startupCity) {
    Get.find<StartupGlobalController>().currentStartup.startupCity =
        startupCity;

    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"startupCity": startupCity});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateStartupDescription(String startupDescription) {
    Get.find<StartupGlobalController>().currentStartup.startupDescription =
        startupDescription;
    try {
      firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"startupDescription": startupDescription});
    } catch (e) {
      print(e.toString());
    }
  }

  void addRequestStage(int stageIndex, String workStreamId) async {
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc("stage " + stageIndex.toString())
        .update({"pendingRequest": true});

    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("status")
        .doc()
        .set({
      "stageDes": "Stage ${stageIndex} is requested for funding.",
      "timestamp": Timestamp.now()
    });
  }

  void uploadWorkImg(List<File> choosenImg) async {
    List<String> urlList = [];
    for (int i = 0; i < choosenImg.length; i++) {
      if (choosenImg[i].path != '') {
        final ref = FirebaseStorage.instance
            .ref()
            .child('startup_img')
            .child('work_img')
            .child(user!.uid + 'folder' + i.toString())
            .child(user!.uid + i.toString() + '.jpg');

        await ref
            .putFile(choosenImg[i])
            .whenComplete(() => print('Image Upload'));

        String url = await ref.getDownloadURL();
        urlList.add(url);
      }
    }
     await FirebaseFirestore.instance
        .collection("Startups")
        .doc(user!.uid)
        .update({'workImgs': FieldValue.arrayUnion(urlList)});
  }
}
