// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/web_app_controller.dart';
import 'package:startupfunding/database/database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/linkedin_url_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class WebAppUrlScreen extends StatelessWidget {
  final TextEditingController _webAppUrl = TextEditingController();

  final WebAppController webAppController = Get.put(WebAppController());

  checkData() {
    if (webAppController.isSelected.value) {
      Get.to(LinkedinUrlScreen());
    } else {
      if (_webAppUrl.text == "") {
        createAlertDialogue("Please Enter Web/App url");
      } else {
        Get.to(LinkedinUrlScreen());
        DataBase().addWebAppUrl(_webAppUrl.text);
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
              'What is the website/app URL of your startup',
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
                  _webAppUrl.text = val;
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Website/App URL...",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Obx(() => Checkbox(
                      value: webAppController.isSelected.value,
                      onChanged: (val) {
                        webAppController.toggoleSelection();
                      },
                    )),
                Text(
                  "Don't have a Website/App",
                  style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                )
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}
