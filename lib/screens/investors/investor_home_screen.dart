// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/screens/investors/chat_screen.dart';
import 'package:startupfunding/screens/investors/investor_feed_screen.dart';
import 'package:startupfunding/screens/investors/investor_profile_screen.dart';
import 'package:startupfunding/screens/investors/notification_screen.dart';
import 'package:startupfunding/screens/investors/request_screen.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class InvestorHomeScreen extends StatelessWidget {
  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  final InvestorGlobalController investorGlobalController =
      Get.put(InvestorGlobalController());
  final screens = [
    InvestorFeedScreen(),
    RequestScreen(),
    NotificationScreen(),
    InvestorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: OnBoardingAppBarTitle(),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Get.off(StartScreen());
                removeSharedPreferences();
              },
              child: CircleAvatar(
                backgroundColor: Colors.grey,
                radius: 20,
              ),
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: IconButton(
                  onPressed: () {
                    Get.to(ChatScreen());
                  },
                  icon: ImageIcon(
                    AssetImage("assets/chat_icon.png"),
                    color: Theme.of(context).primaryColor,
                  ),
                )),
          ],
          backgroundColor: Colors.white,
        ),
        body: Obx(
          () => investorGlobalController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IndexedStack(
                  index: investorGlobalController.currentIndex.value,
                  children: screens,
                ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: investorGlobalController.currentIndex.value,
            onTap: (index) {
              investorGlobalController.currentIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/startup-bottom.png"),
                  ),
                  label: 'Startups',
                  backgroundColor: Theme.of(context).primaryColor),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/request.png"),
                  ),
                  label: 'Requests',
                  backgroundColor: Theme.of(context).primaryColor),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/notification.png"),
                  ),
                  label: 'Notification',
                  backgroundColor: Theme.of(context).primaryColor),
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/test_image.png"),
                    
                  ),
                  label: 'Profile',
                  backgroundColor: Theme.of(context).primaryColor)
            ],
          ),
        ));
  }
}
