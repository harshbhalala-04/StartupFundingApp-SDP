// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class PitchDeckScreen extends StatelessWidget {
  const PitchDeckScreen({Key? key}) : super(key: key);

  checkData(){}

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
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Please share your pitch deck (To know more about your startup idea)',
              style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Image.asset("assets/upload.png", height: 68,),
            ),
            SizedBox(height: 10,),
            Center(
              child: Text(
                'Drag & Drop Files Here',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Cabin",
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(height: 20,),
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Browse File',
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Cabin", fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
            )
          ],
        ),
      
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}
