// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/screens/start_screen.dart';

class InvestorProfileScreen extends StatelessWidget {
  const InvestorProfileScreen({Key? key}) : super(key: key);

  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          FirebaseAuth.instance.signOut();
          Get.off(StartScreen());
          removeSharedPreferences();
        },
        child: Text("Log out"),
      ),
    );
  }
}
