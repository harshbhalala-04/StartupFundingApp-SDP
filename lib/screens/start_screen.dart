// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/screens/auth_screen.dart';

class StartScreen extends StatefulWidget {
  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Startup Funding',
          style: TextStyle(
            fontFamily: "Cabin",
            fontSize: 24,
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Center(
            child: Text(
              'Continue As',
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Cabin",
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              Get.to(AuthScreen(
                title: 'Investor',
              ));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/investors.jfif"),
              radius: 60,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Investor",
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 30,
          ),
          InkWell(
            onTap: () {
              Get.to(AuthScreen(
                title: 'Startup',
              ));
            },
            child: CircleAvatar(
              backgroundImage: AssetImage("assets/startup.png"),
              radius: 60,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "Startup",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
