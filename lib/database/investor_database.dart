import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class InvestorDataBase {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

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
}
