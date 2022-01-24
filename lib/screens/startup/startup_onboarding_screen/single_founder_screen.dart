// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:startupfunding/controllers/startup_controllers/image_picker_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/startup_category_screen.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

enum Selection { Yes, No }

class SingleFounderScreen extends StatefulWidget {
  @override
  State<SingleFounderScreen> createState() => _SingleFounderScreenState();
}

class _SingleFounderScreenState extends State<SingleFounderScreen> {
  Selection? reply;
  bool isVisible = false;
  final ImagePickerController imagePickerController =
      Get.put(ImagePickerController());
  final TextEditingController secondFounderName = TextEditingController();
  final TextEditingController secondFounderEmail = TextEditingController();
  final TextEditingController secondFounderLinkedinUrl =
      TextEditingController();

  checkData() {
    if (reply == Selection.Yes) {
      StartupDataBase().addFounderInfo(
        "Yes",
        secondFounderName.text,
        secondFounderEmail.text,
        secondFounderLinkedinUrl.text,
      );
    } else {
      StartupDataBase().uploadUserImages(
          imagePickerController.choosenImage.value, "Co-Founder");
      StartupDataBase().addFounderInfo("No", secondFounderName.text,
          secondFounderEmail.text, secondFounderLinkedinUrl.text);
    }

    Get.to(StartupCategoryScreen());
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      reply = Selection.Yes;
    });
    super.initState();
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'Are you a single founder?',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    reply = Selection.Yes;
                    isVisible = false;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Selection.Yes,
                      groupValue: reply,
                      onChanged: (Selection? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('Yes'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    reply = Selection.No;
                    isVisible = true;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Selection.No,
                      groupValue: reply,
                      onChanged: (Selection? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('No'),
                  ],
                ),
              ),
              isVisible
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (val) {
                          secondFounderName.text = val;
                        },
                        decoration: InputDecoration(
                          hintText: "Name of the second founder",
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isVisible
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (val) {
                          secondFounderEmail.text = val;
                        },
                        decoration: InputDecoration(
                          hintText: "Email of the second founder",
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isVisible
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        onChanged: (val) {
                          secondFounderLinkedinUrl.text = val;
                        },
                        decoration: InputDecoration(
                          hintText:
                              "Enter the linkedin URL for the second founder",
                          border: OutlineInputBorder(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10)),
                            borderSide: BorderSide(width: 2),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              isVisible
                  ? Text(
                      "Upload Second founder Image",
                      style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  : Container(),
              isVisible
                  ? SizedBox(
                      height: 20,
                    )
                  : Container(),
              isVisible
                  ? Center(
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
                                                color: Color.fromRGBO(
                                                    0, 0, 0, 0.25),
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
                    )
                  : Container()
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
