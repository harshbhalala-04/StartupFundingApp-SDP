import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class InvestorDataBase {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addInvestorPersonalInfo(String firstName, String lastName, String linkedinUrl,
      String cityName) async {
    await firestore.collection("Investors").doc(user!.uid).update({
      "firstName": firstName,
      "lastName": lastName,
      "linkedinUrl": linkedinUrl,
      "cityName": cityName
    });
  }

  addInvestorInvestmentDetails(String investedBefore, String category,
      List<String> experience, String assets) async {
    await firestore.collection("Investors").doc(user!.uid).update({
      "investedBefore": investedBefore,
      "category": category,
      "assets": assets,
      "experience": FieldValue.arrayUnion(experience)
    });
  }

  addInvestorPersonalizeInfo(List<Object?> expertise, String preferInvestment,
      String mentorStartup) async {
    await firestore.collection("Investors").doc(user!.uid).update({
      "expertise": FieldValue.arrayUnion(expertise),
      "preferInvestment": preferInvestment,
      "mentorStartup": mentorStartup,
    });
  }

  uploadInvestorImg(File userImages) async {
    if (userImages.path != '') {
      final ref = FirebaseStorage.instance
          .ref()
          .child('investor_img')
          .child(user!.uid + '.jpg');

      await ref.putFile(userImages).whenComplete(() => print('Image Upload'));

      String url = await ref.getDownloadURL();

      await firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"investorImg": url});
    }
  }

  ///Add Startup to exclude list
  void addStartupToExcludeList(String startupUid, bool fromInvite) async {
    List<String> startupUidList = [];
    startupUidList.add(startupUid);

    try {
      await firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"excludeStartup": FieldValue.arrayUnion(startupUidList)});

      if (fromInvite) {
        List<String> investorUidList = [];
        investorUidList.add(user!.uid);
        await firestore.collection("Startups").doc(startupUid).update(
            {"excludeInvestor": FieldValue.arrayUnion(investorUidList)});
      }
    } catch (e) {
      print("Error info:          ");
      print(e);
    }
  }

  ///Add Startup to invite list
  void addStartupToInviteList(
      String startupUid,
      String startupImg,
      String startupName,
      String investorUid,
      String investorImg,
      String investorName) async {
    DateTime time = DateTime.now();

    List<dynamic> myInviteList = [];
    List<dynamic> otherInviteList = [];

    try {
      await firestore.collection("Investors").doc(user!.uid).get().then((val) {
        myInviteList = val.data()!['inviteList'];
      });
      await firestore.collection("Startups").doc(startupUid).get().then((val) {
        otherInviteList = val.data()!['inviteList'];
      });

      List<Map<String, dynamic>> myMap = [
        {
          "time": time,
          "recieved": "",
          "sent": startupName,
          "image": startupImg,
          "id": startupUid
        }
      ];

      List<Map<String, dynamic>> otherMap = [
        {
          "time": time,
          "recieved": investorName,
          "sent": "",
          "image": investorImg,
          "id": investorUid
        }
      ];

      await firestore.collection("Investors").doc(user!.uid).update({
        'inviteList': FieldValue.arrayUnion(myMap),
        'latestConnectionSentUid': startupUid,
      });

      await firestore
          .collection("Startups")
          .doc(startupUid)
          .update({'inviteList': FieldValue.arrayUnion(otherMap)});
    } catch (e) {
      print("Error info");
      print(e);
    }
  }

  ///Remove Startup from pending list
  void removeStartupFromPending(String startupUid) async {
    try {
      await firestore
          .collection("Investors")
          .doc(user!.uid)
          .get()
          .then((value) {
        Map<String, dynamic> myMap = value.data()!;
        List<dynamic> inviteList = myMap['inviteList'];
        inviteList.removeWhere((element) => element['id'] == startupUid);

        firestore
            .collection("Investors")
            .doc(user!.uid)
            .update({"inviteList": inviteList});
      });

      await firestore
          .collection("Startups")
          .doc(startupUid)
          .get()
          .then((value) {
        Map<String, dynamic> myMap = value.data()!;
        List<dynamic> inviteList = myMap['inviteList'];
        inviteList.removeWhere((element) => element['id'] == user!.uid);

        firestore
            .collection("Startups")
            .doc(startupUid)
            .update({"inviteList": inviteList});
      });
    } catch (e) {
      print(e);
    }
  }

  ///Accept offer of Startup
  void acceptOffer(String investorName, String investorImg, String startupName,
      String startupLogo, String startupUid) async {
    DateTime time = DateTime.now();

    List<Map<String, dynamic>> myMatchMap = [
      {
        "friendname": startupName,
        "friendImage": startupLogo,
        "friendUid": startupUid
      }
    ];

    List<Map<String, dynamic>> otherMatchMap = [
      {
        "friendname": investorName,
        "friendImage": investorImg,
        "friendUid": user!.uid
      }
    ];

    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({'matchUsers': FieldValue.arrayUnion(myMatchMap)});

      firestore
          .collection("Startups")
          .doc(startupUid)
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
}
