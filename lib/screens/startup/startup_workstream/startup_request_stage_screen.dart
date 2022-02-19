// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';

class StartupRequestStageScreen extends StatelessWidget {
  const StartupRequestStageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Stage",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Container(),
      // body: ListView.builder(
      //   itemCount:
      //       Get.find<StartupGlobalController>().currentStartup.stage?.length,
      //   itemBuilder: (ctx, index) {
      //     return Container();
      //   },
      // ),
    );
  }
}
