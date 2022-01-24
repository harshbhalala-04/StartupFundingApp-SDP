// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_home_controller.dart';
import 'package:startupfunding/screens/investors/chat_screen.dart';
import 'package:startupfunding/screens/investors/investor_feed_screen.dart';
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

  final InvestorHomeController investorHomeController =
      Get.put(InvestorHomeController());
  final screens = [
    ChatScreen(),
    InvestorFeedScreen(),
    RequestScreen(),
    NotificationScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: OnBoardingAppBarTitle(),
          centerTitle: true,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 20,
            ),
          ),
          backgroundColor: Colors.white,
        ),
        body: Obx(
          () => IndexedStack(
            index: investorHomeController.currentIndex.value,
            children: screens,
          ),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
            currentIndex: investorHomeController.currentIndex.value,
            onTap: (index) {
              investorHomeController.currentIndex.value = index;
            },
            items: [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage("assets/chat.png"),
                  ),
                  label: "Chats",
                  backgroundColor: Theme.of(context).primaryColor),
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
            ],
          ),
        ));
  }
}
