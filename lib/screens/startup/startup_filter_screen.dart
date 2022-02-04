// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_filter_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/screens/startup/startup_home_screen.dart';
import 'package:startupfunding/screens/startup/startup_investors_screen.dart';

class StartupFilterScreen extends StatefulWidget {
  const StartupFilterScreen({Key? key}) : super(key: key);

  @override
  State<StartupFilterScreen> createState() => _StartupFilterScreenState();
}

class _StartupFilterScreenState extends State<StartupFilterScreen> {
  final StartupFilterController startupFilterController =
      Get.put(StartupFilterController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Filter",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Show matching categories",
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 18,
                  ),
                ),
                Obx(() => Switch(
                    value: startupFilterController.isFilterApplied.value,
                    activeColor: Theme.of(context).primaryColor,
                    onChanged: (val) {
                      startupFilterController.isFilterApplied.value = val;
                    })),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                height: 40,
                width: 230,
                child: ElevatedButton(
                  child: Text(
                    'Apply Filter',
                    style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                  ),
                  onPressed: () {
                    Get.find<StartupGlobalController>().investersList = [];
                    Get.find<StartupGlobalController>().hasMoreData = true;
                    Get.find<StartupGlobalController>().lastUser = null;
                    Get.find<StartupGlobalController>().getInvestorsForFeed();
                    Get.to(StartupHomeScreen());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
