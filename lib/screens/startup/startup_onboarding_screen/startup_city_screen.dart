// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/pitch_deck_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/reg_startup_name.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class StartupCityScreen extends StatelessWidget {
  final TextEditingController _startupCityController = TextEditingController();

  checkData() {
    if (_startupCityController.text == "") {
      createAlertDialogue("Please enter city name");
    } else {
      Get.to(PitchDeckScreen());
      StartupDataBase().addStartupCityName(_startupCityController.text);
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
              'In which city do you operate this startup?',
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
                  _startupCityController.text = val;
                },
                decoration: InputDecoration(
                  hintText: "Enter City Name...",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
        checkData: checkData,
      ),
    );
  }
}
