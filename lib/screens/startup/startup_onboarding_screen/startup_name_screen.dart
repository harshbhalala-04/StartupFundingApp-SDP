// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/image_picker_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/reg_startup_name.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class StartupNameScreen extends StatelessWidget {
  final TextEditingController _startupNameController = TextEditingController();
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  checkData() {
    if (_startupNameController.text == "") {
      createAlertDialogue("Please enter your startup name.");
    } else if (imagePickerController.choosenImage.value.path == "") {
      createAlertDialogue("Please enter your startup logo.");
    } else {
      imagePickerController.isUploadedImage.value = false;
      Get.to(RegStartupName());
      StartupDataBase().uploadUserImages(
          imagePickerController.choosenImage.value, "startupLogo");
      StartupDataBase().addStartupName(_startupNameController.text);
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
              'What is the name of your startup?',
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
                  _startupNameController.text = val;
                },
                decoration: InputDecoration(
                  hintText: "Enter Your Startup Name...",
                  border: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width: 2),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              "Upload Your Startup logo (Required)",
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
                                  image: FileImage(
                                      imagePickerController.choosenImage.value),
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
      bottomNavigationBar: BottomNavigationButton(
        checkData: checkData,
      ),
    );
  }
}
