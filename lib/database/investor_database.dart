import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/src/widgets/editable_text.dart';

class InvestorDataBase {
  addInvestorPersonalInfo(TextEditingController firstName, TextEditingController lastName, TextEditingController linkedinUrl, TextEditingController cityName, User? user) {

    FirebaseFirestore.instance.collection("Investors").doc(user!.uid).update({
      "firstName": firstName.text,
      "lastName": lastName.text,
      "likedinUrl": linkedinUrl.text,
      "cityName": cityName.text
    });
  }
}
