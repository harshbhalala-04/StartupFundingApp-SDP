// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startupfunding/global.dart';
import 'package:startupfunding/models/startup_model.dart';
import 'package:startupfunding/screens/investors/startup_detail_screen.dart';
import 'package:startupfunding/screens/start_screen.dart';

class UserProfileScreen extends StatefulWidget {
  final String uid;

  UserProfileScreen({required this.uid});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool isLoading = false;
  StartupModel startupModel = new StartupModel();
  @override
  void initState() {
    // TODO: implement initState
    fetchUserData();
    super.initState();
  }

  fetchUserData() async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("Startups")
        .doc(widget.uid)
        .get()
        .then((val) {
      startupModel = StartupModel.fromJson(val.data()!);
    });
    setState(() {
      isLoading = false;
    });
  }

  bool buttonVisible = false;

  void checkButtonVisible() {
    if (userType == "Startup") {
      buttonVisible = false;
    }
    if (userType == "Investor") {
      buttonVisible = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            return isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : StartupDetailScreen(
                    fromReq: false,
                    viewProfile: userType == "Startup" ? true : false,
                    fromDynamic: true,
                    uid: widget.uid,
                    startup: startupModel,
                  );
          } else {
            return StartScreen();
          }
        });
  }
}
