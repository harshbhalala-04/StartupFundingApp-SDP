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
        await firestore.collection("Startups").doc(user!.uid).update(
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
}
