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
      "likedinUrl": linkedinUrl,
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
}
