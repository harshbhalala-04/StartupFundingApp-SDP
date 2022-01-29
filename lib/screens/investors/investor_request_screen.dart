// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_request_controller.dart';
import 'package:startupfunding/screens/investors/investor_request_recieve_screen.dart';
import 'package:startupfunding/screens/investors/investor_request_sent_screen.dart';

class InvestorRequestScreen extends StatelessWidget {
  final InvestorRequestController investorRequestController =
      Get.put(InvestorRequestController());
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            toolbarHeight: 0,
            bottom: TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black,
              tabs: [
                Tab(
                  child: Text(
                    "Recieved",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                ),
                Tab(
                  child: Text(
                    "Sent",
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: Obx(
            () => investorRequestController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    children: [
                      Obx(() => investorRequestController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InvestorRequestRecieveScreen()),
                      Obx(() => investorRequestController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : InvestorRequestSentScreen()),
                    ],
                  ),
          )),
    );
  }
}
