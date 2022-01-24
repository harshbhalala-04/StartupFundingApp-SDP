// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/screens/startup/startup_chat_screen.dart';
import 'package:startupfunding/screens/startup/startup_investors_screen.dart';
import 'package:startupfunding/screens/startup/startup_notification_screen.dart';
import 'package:startupfunding/screens/startup/startup_request_screen.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class StartupHomeScreen extends StatefulWidget {
  const StartupHomeScreen({Key? key}) : super(key: key);

  @override
  State<StartupHomeScreen> createState() => _StartupHomeScreenState();
}

class _StartupHomeScreenState extends State<StartupHomeScreen> {
  int currentIndex = 1;
  final List<Widget> screens = [
    StartupChatScreen(),
    StartupInvestorsScreen(),
    StartupRequestScreen(),
    StartupNotificationScreen(),
  ];
  void onTappedBar(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OnBoardingAppBarTitle(),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: AssetImage("assets/test_image.png"),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
       
        currentIndex: currentIndex,
        onTap: onTappedBar,
        items: [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/chat_icon.png"),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            label: "Chat",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/investor_detail_icon.png"),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            label: 'Investors',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/connection_request_icon.png"),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            label: "Request",
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage("assets/notification_icon.png"),
            ),
            backgroundColor: Theme.of(context).primaryColor,
            label: "Notification",
          ),
        ],
      ),
    );
  }
}
