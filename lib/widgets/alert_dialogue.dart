// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

createAlertDialogue(String msg) {
  Get.defaultDialog(
    middleText: msg,
    title: "",
    middleTextStyle: TextStyle(fontSize: 20),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
              onPressed: () {
                Get.back();
              },
              child: Text('Close'),
              style: TextButton.styleFrom(
                  textStyle: TextStyle(fontFamily: "Cabin", fontSize: 16))),
        ],
      )
    ],
    barrierDismissible: false,
  );
}
