// ignore_for_file: prefer_const_constructors, unnecessary_new, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/image_picker_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/investors/investor_onboarding_screen/investor_investment_profile_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class InvestorPersonalInfoScreen extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  InvestorPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _InvestorPersonalInfoScreenState createState() =>
      _InvestorPersonalInfoScreenState();
}

class _InvestorPersonalInfoScreenState
    extends State<InvestorPersonalInfoScreen> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController linkedinUrl = new TextEditingController();
  TextEditingController cityName = new TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  checkData() {
    if (firstName.text == "") {
      createAlertDialogue("Please enter your first name");
    } else if (lastName.text == "") {
      createAlertDialogue("Please enter your last name");
    } else if (linkedinUrl.text == "") {
      createAlertDialogue("Please enter your linkedin url");
    } else if (cityName.text == "") {
      createAlertDialogue("Please enter your City name");
    } else if (imagePickerController.choosenImage.value.path == "") {
      createAlertDialogue("Please upload your profile photo");
    } else {
      Get.to(InvestorInvestmentProfileScreen());
      InvestorDataBase()
          .uploadInvestorImg(imagePickerController.choosenImage.value);
      InvestorDataBase().addInvestorPersonalInfo(
          firstName.text, lastName.text, linkedinUrl.text, cityName.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OnBoardingAppBarTitle(),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: Container(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20,
              ),
              Container(
                  child: Text(
                "Help us get to know you better!",
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: const EdgeInsets.fromLTRB(10, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: firstName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "First Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(10, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: lastName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Last Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(10, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: SvgPicture.asset("assets/linkedin.svg"),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: linkedinUrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Linkedin Url",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(10, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.location_city,
                        color: Colors.grey,
                        size: 25,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: cityName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter the city do you live in?",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Upload your profile photo",
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Center(
                child: Obx(
                  () => imagePickerController.isLoading.value
                      ? CircularProgressIndicator()
                      : InkWell(
                          onTap: () {
                            imagePickerController.pickImage(context);
                          },
                          child: Obx(() => imagePickerController
                                  .isUploadedImage.value
                              ? Container(
                                  child: Image(
                                    width: 90,
                                    height: 90,
                                    image: FileImage(imagePickerController
                                        .choosenImage.value),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Container(
                                  width: 90,
                                  height: 90,
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.25),
                                          blurRadius: 5,
                                        ),
                                      ]),
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/add.svg',
                                    ),
                                  ))),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}
