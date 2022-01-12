// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_otp/flutter_otp.dart';
import 'package:get/get.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/user_name_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';

class VerifyPhoneScreen extends StatelessWidget {
  final String phoneNo;
  VerifyPhoneScreen({required this.phoneNo});

  final TextEditingController _otpController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  FlutterOtp otp = FlutterOtp();

  void checkData() {
    if (_otpController.text == null || _otpController.text == "") {
      createAlertDialogue("Please Enter OTP");
    } else {
      print("button pressed");
      Get.to(UserNameScreen());
    }

    // if (otp.resultChecker(int.parse(_otpController.text))) {
    //   print("OTP is correct");
    // } else {
    //   print("OTP is incorrect");
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Startup Funding',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Cabin",
          ),
        ),
        centerTitle: true,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Verify Your Phone Number',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    _phoneNoController.text = val;
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50,
              ),
              Center(
                  child: Container(
                      width: 150,
                      child: ElevatedButton(
                        onPressed: () {
                          otp.sendOtp(_phoneNoController.text, "Your OTP is: ",
                              1000, 9999, "+1");
                        },
                        child: Text(
                          "Get OTP",
                          style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                        ),
                      ))),
              SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  width: 200,
                  child: TextFormField(
                    controller: _otpController,
                    textAlign: TextAlign.start,
                    cursorHeight: 14,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: "Enter OTP...",
                      hintStyle: TextStyle(fontSize: 14),
                    ),
                    onSaved: (value) {
                      _otpController.text = value!;
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
        checkData: checkData,
      ),
    );
  }
}
