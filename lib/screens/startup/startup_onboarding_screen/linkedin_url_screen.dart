// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/single_founder_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class LinkedinUrlScreen extends StatefulWidget {
  @override
  State<LinkedinUrlScreen> createState() => _LinkedinUrlScreenState();
}

class _LinkedinUrlScreenState extends State<LinkedinUrlScreen> {
  final TextEditingController _linkedinUrlController = TextEditingController();

  bool error = false;

  checkData() {
    print(_linkedinUrlController.text.substring(0, 21));
    if (_linkedinUrlController.text == "") {
      createAlertDialogue("Please enter your linkedin url.");
    } else {
      if (_linkedinUrlController.text.length < 20) {
        setState(() {
          error = true;
        });
      } else if (_linkedinUrlController.text.substring(0, 21) ==
          "https://linkedin.com/") {
        print(_linkedinUrlController.text.substring(0, 21));
        setState(() {
          error = false;
        });
        Get.to(SingleFounderScreen());
        StartupDataBase().addLinkedinUrl(_linkedinUrlController.text);
      } else {
        setState(() {
          error = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: OnBoardingAppBarTitle(),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Enter linkedin URL',
              style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                onChanged: (val) {
                  _linkedinUrlController.text = val;
                },
                decoration: InputDecoration(
                  hintText: "https:/linkedin.com/",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            error
                ? Text(
                    "Enter valid linkedin url",
                    style: TextStyle(
                      color: Colors.red,
                      fontFamily: "Cabin",
                      fontSize: 16,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
        checkData: checkData,
      ),
    );
  }
}
