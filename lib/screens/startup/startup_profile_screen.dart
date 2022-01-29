// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/custom_card.dart';

// 1. assets/view_profile_icon.png
// 2. assets/view_balance_icon.png
// 3. assets/edit_profile_icon.png
// 4. assets/share_icon.png
// 5. assets/logout_icon.png

class StartupProfileScreen extends StatelessWidget {
  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
              onTap: () {},
              child: CustomCard(
                  iconImage: "assets/view_profile_icon.png",
                  title: "View Profile")),
          InkWell(
              onTap: () {},
              child: CustomCard(
                  iconImage: "assets/edit_profile_icon.png",
                  title: "Edit Profile")),
          InkWell(
              onTap: () {},
              child: CustomCard(
                  iconImage: "assets/view_balance_icon.png",
                  title: "View Balance")),
          InkWell(
              onTap: () {},
              child: CustomCard(
                  iconImage: "assets/share_icon.png", title: "Share Startup")),
          InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.off(StartScreen());
                removeSharedPreferences();
              },
              child: CustomCard(
                  iconImage: "assets/logout_icon.png", title: "Log Out")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    primary: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Delete my account",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
