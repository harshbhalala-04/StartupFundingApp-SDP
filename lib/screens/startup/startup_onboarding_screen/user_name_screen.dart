// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/image_picker_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/startup_name_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class UserNameScreen extends StatelessWidget {
  final TextEditingController _userNameController = TextEditingController();
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());

  checkData() {
    if (_userNameController.text == "") {
      createAlertDialogue("Please enter your name.");
    } else if (imagePickerController.choosenImage.value.path == "") {
      createAlertDialogue("Please enter your profile image.");
    } else {
      imagePickerController.isUploadedImage.value = false;
      Get.to(StartupNameScreen());

      StartupDataBase().addUserName(_userNameController.text);
      StartupDataBase().uploadUserImages(
          imagePickerController.choosenImage.value, "Founder");
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Let’s Start with the basics. What is your name?',
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
                    _userNameController.text = val;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter Your Name...",
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
                "Upload Your Image",
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
      bottomNavigationBar: BottomNavigationButton(
        checkData: checkData,
      ),
    );
  }
}
