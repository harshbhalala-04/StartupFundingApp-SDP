// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_request_controller.dart';
import 'package:startupfunding/screens/startup/startup_request_recieve_screen.dart';
import 'package:startupfunding/screens/startup/startup_request_sent_screen.dart';

class StartupRequestScreen extends StatelessWidget {
  final StartupRequestController startupRequestController =
      Get.put(StartupRequestController());

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
                  child: Text("Recieved"),
                ),
                Tab(
                  child: Text("Sent"),
                ),
              ],
            ),
          ),
          body: Obx(
            () => startupRequestController.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : TabBarView(
                    children: [
                        Obx(() => startupRequestController.isLoading.value
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : StartupRequestRecieveScreen()),
                      Obx(() => startupRequestController.isLoading.value
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : StartupRequestSentScreen()),
                    ],
                  ),
          )),
    );
  }
}
