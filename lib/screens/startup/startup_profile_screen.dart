// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/screens/investors/startup_detail_screen.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/screens/startup/startup_profile_management_screen/startup_edit_profile_screen.dart';
import 'package:startupfunding/screens/startup/startup_profile_management_screen/startup_view_balance_screen.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/custom_card.dart';
import 'package:share_plus/share_plus.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class StartupProfileScreen extends StatelessWidget {
  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  Future<void> createDynamicLink() async {
    Uri imageUri = Uri.parse(
        Get.find<StartupGlobalController>().currentStartup.startupLogoUrl!);
    String userName =
        Get.find<StartupGlobalController>().currentStartup.startupName!;
    String userId = Get.find<StartupGlobalController>().currentStartup.uid!;
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: "https://startupfunding.page.link",
      link: Uri.parse("https://startupfunding.page.link/$userId"),
      androidParameters: AndroidParameters(
          packageName: "com.example.startupfunding", minimumVersion: 0),
      socialMetaTagParameters: SocialMetaTagParameters(
        title: userName,
        imageUrl: imageUri,
      ),
    );

    final ShortDynamicLink shortLink = await parameters.buildShortLink();

    Uri url = shortLink.shortUrl;

    await Share.share(url.toString(), subject: userName);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                Get.to(StartupDetailScreen(
                  fromReq: false,
                  startup: Get.find<StartupGlobalController>().currentStartup,
                  viewProfile: true,
                  fromDynamic: false,
                ));
              },
              child: CustomCard(
                  iconImage: "assets/view_profile_icon.png",
                  title: "View Profile")),
          InkWell(
              onTap: () {
                Get.to(StartupEditProfileScreen());
              },
              child: CustomCard(
                  iconImage: "assets/edit_profile_icon.png",
                  title: "Edit Profile")),
          InkWell(
            onTap: () {
              createDynamicLink();
            },
            child: Text("Share Startup"),
          ),
          InkWell(
              onTap: () {
                Get.to(StartupViewBalanceScreen());
              },
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
