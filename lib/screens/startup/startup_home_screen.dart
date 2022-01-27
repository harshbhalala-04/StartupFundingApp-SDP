// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_label

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/screens/startup/startup_chat_screen.dart';
import 'package:startupfunding/screens/startup/startup_investors_screen.dart';
import 'package:startupfunding/screens/startup/startup_notification_screen.dart';
import 'package:startupfunding/screens/startup/startup_profile_screen.dart';
import 'package:startupfunding/screens/startup/startup_request_screen.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class StartupHomeScreen extends StatefulWidget {
  const StartupHomeScreen({Key? key}) : super(key: key);

  @override
  State<StartupHomeScreen> createState() => _StartupHomeScreenState();
}

class _StartupHomeScreenState extends State<StartupHomeScreen> {
  final List<Widget> screens = [
    StartupInvestorsScreen(),
    StartupRequestScreen(),
    StartupNotificationScreen(),
    StartupProfileScreen(),
  ];

  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  final StartupGlobalController startupGlobalController =
      Get.put(StartupGlobalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OnBoardingAppBarTitle(),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {},
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage("assets/appbar_logo.png"),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        actions: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
              child: IconButton(
                onPressed: () {},
                icon: ImageIcon(
                  AssetImage("assets/chat_icon.png"),
                  color: Theme.of(context).primaryColor,
                ),
              )),
        ],
      ),
      body: Obx(
        () => startupGlobalController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : IndexedStack(
                index: startupGlobalController.currentIndex.value,
                children: screens,
              ),
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          currentIndex: Get.find<StartupGlobalController>().currentIndex.value,
          onTap: (index) {
            Get.find<StartupGlobalController>().currentIndex.value = index;
          },
          items: [
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
            BottomNavigationBarItem(
              icon: Obx(
                () => startupGlobalController.isLoading.value ||
                        startupGlobalController.currentStartup.startupLogoUrl ==
                            null
                    ? CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                      )
                    : CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                            startupGlobalController
                                .currentStartup.startupLogoUrl!),
                      ),
              ),
              backgroundColor: Theme.of(context).primaryColor,
              label: "Profile",
            ),
          ],
        ),
      ),
    );
  }
}
