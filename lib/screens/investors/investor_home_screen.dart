// ignore_for_file: prefer_const_constructors, unnecessary_new

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_request_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/image_picker_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/screens/investors/investor_filter_screen.dart';
import 'package:startupfunding/screens/investors/investor_workstream/chat_screen.dart';
import 'package:startupfunding/screens/investors/investor_feed_screen.dart';
import 'package:startupfunding/screens/investors/investor_profile_screen.dart';
import 'package:startupfunding/screens/investors/notification_screen.dart';
import 'package:startupfunding/screens/investors/investor_request_screen.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

import '../../global.dart';

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
    InvestorRequestScreen(),
    InvestorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    print("Investor Home screen starts building");
    print(Get.find<InvestorGlobalController>().currentInvestor.investorImg);
    
    return Scaffold(
      appBar: AppBar(
        title: OnBoardingAppBarTitle(),
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: InkWell(
            onTap: () {
              Get.to(ChatScreen());
            },
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage("assets/appbar_logo.png"),
            ),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(InvestorFilterScreen());
            },
            icon: ImageIcon(
              AssetImage("assets/filter.png"),
              color: Theme.of(context).primaryColor,
            ),
          ),
          IconButton(
            onPressed: () {
              Get.to(ChatScreen());
            },
            icon: ImageIcon(
              AssetImage("assets/chat_icon.png"),
              color: Theme.of(context).primaryColor,
            ),
          ),
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
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(color: Colors.white),
          backgroundColor: Theme.of(context).primaryColor,
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
                icon: Obx(
                  () => fromSignup
                      ? CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.grey,
                          backgroundImage: FileImage(
                              Get.find<ImagePickerController>()
                                  .choosenImage
                                  .value),
                        )
                      : investorGlobalController.isLoading.value ||
                              investorGlobalController
                                      .currentInvestor.investorImg ==
                                  null
                          ? CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey,
                            )
                          : CircleAvatar(
                              radius: 18,
                              backgroundColor: Colors.grey,
                              backgroundImage: CachedNetworkImageProvider(
                                  Get.find<InvestorGlobalController>()
                                      .currentInvestor
                                      .investorImg!),
                            ),
                ),
                label: 'Profile',
                backgroundColor: Theme.of(context).primaryColor)
          ],
        ),
      ),
    );
  }
}
