// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/widgets/custom_textformfield.dart';

class StartupEditProfileScreen extends StatefulWidget {
  StartupEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<StartupEditProfileScreen> createState() =>
      _StartupEditProfileScreenState();
}

class _StartupEditProfileScreenState extends State<StartupEditProfileScreen> {
  TextEditingController startupUserNameController = new TextEditingController();
  TextEditingController startupNameController = new TextEditingController();
  TextEditingController startupRegNameController = new TextEditingController();
  TextEditingController startupPhoneNoController = new TextEditingController();
  TextEditingController startupEmailController = new TextEditingController();
  // TextEditingController startupWebAppUrlController =
  //     new TextEditingController();
  TextEditingController startupLinkedinUrlController =
      new TextEditingController();
  TextEditingController startupCityController = new TextEditingController();
  TextEditingController startupDescriptionController =
      new TextEditingController();

  @override
  void initState() {
    super.initState();

    startupUserNameController.text =
        Get.find<StartupGlobalController>().currentStartup.userName!;
    startupNameController.text =
        Get.find<StartupGlobalController>().currentStartup.startupName!;
    startupRegNameController.text =
        Get.find<StartupGlobalController>().currentStartup.regStartupName!;
    startupPhoneNoController.text =
        Get.find<StartupGlobalController>().currentStartup.phoneNo!;
    startupEmailController.text =
        Get.find<StartupGlobalController>().currentStartup.email!;
    // startupWebAppUrlController.text =
    //     Get.find<StartupGlobalController>().currentStartup.linkedinUrl!;
    startupLinkedinUrlController.text =
        Get.find<StartupGlobalController>().currentStartup.linkedinUrl!;
    startupCityController.text =
        Get.find<StartupGlobalController>().currentStartup.startupCity!;
    startupDescriptionController.text =
        Get.find<StartupGlobalController>().currentStartup.startupDescription!;
  }

  List<String> startupCategories = [
    "Advertising",
    "Aerospace",
    "Agriculture",
    "AI",
    "Analytics",
    "Animation",
    "AR/VR",
    "Architecture",
    "Art & Photography",
    "Automative",
    "Beauty",
    "Big Data",
    "Blockchain",
    "Careers",
    "Communication",
    "Computer Vision",
    "Construction",
    "Consumer Goods",
    "Dating/Matrimonial",
    "Defence",
    "Design",
    "Education",
    "Energy & Sustainability",
    "Enterprise Software",
    "Events",
    "Fashion",
    "FinTech",
    "Food & Beverages",
    "Gaming",
    "Gifting",
    "Grocery",
    "Hardware",
    "Healthcare",
    "Human Resources",
    "Information/Tech",
    "Internet of Things",
    "IT Services",
    "Legal",
    "Logistics",
    "Manufacturing",
    "Marketing",
    "Media & Entertainment",
    "Nanotechnology",
    "Networking",
    "Pets & Animals",
    "Printing",
    "Real Estate",
    "Retail",
    "Robotics",
    "Safety",
    "Security",
    "Services",
    "Social Impact",
    "Social Network",
    "Sports",
    "Storage",
    "Transportation",
    "Travel & Tourism"
  ];

  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style:
              TextStyle(color: Colors.black, fontFamily: "Cabin", fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color.fromRGBO(10, 102, 194, 0.9),
                        Color.fromRGBO(117, 104, 184, 1)
                      ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Colors.deepPurpleAccent),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                Get.find<StartupGlobalController>()
                                    .currentStartup
                                    .founderImg!),
                            radius: 50.0,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Edit Profile Photo",
                            style: TextStyle(
                              fontFamily: "Cabin",
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 70),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                Get.find<StartupGlobalController>()
                                    .currentStartup
                                    .startupLogoUrl!),
                            radius: 50.0,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Edit Startup Logo",
                            style: TextStyle(
                              fontFamily: "Cabin",
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupUserNameController,
                  onEditingComplete: () {
                    StartupDataBase()
                        .updateStartupUserName(startupUserNameController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupNameController,
                  onEditingComplete: () {
                    StartupDataBase()
                        .updateStartupName(startupNameController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Startup Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupRegNameController,
                  onEditingComplete: () {
                    StartupDataBase().updateStartupRegisteredName(
                        startupRegNameController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Startup Rregistered Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupPhoneNoController,
                  onEditingComplete: () {
                    StartupDataBase()
                        .updateStartupPhoneNo(startupPhoneNoController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Phone No",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupEmailController,
                  onEditingComplete: () {
                    StartupDataBase()
                        .updateStartupEmail(startupEmailController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  // controller: startupWebAppUrlController,
                  // onEditingComplete: () {
                  //   StartupDataBase()
                  //       .updateStartupUserName(startupWebAppUrlController.text);
                  // },
                  decoration: InputDecoration(
                    labelText: "Website/App Url",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupLinkedinUrlController,
                  onEditingComplete: () {
                    StartupDataBase().updateStartupLinkedinUrl(
                        startupLinkedinUrlController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Linkedin Url",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: startupCityController,
                  onEditingComplete: () {
                    StartupDataBase()
                        .updateStartupCity(startupCityController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select category for your project',
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: double.infinity,
                    child: DropdownSearch<String>(
                      mode: Mode.MENU,
                      showSearchBox: true,
                      showSelectedItems: true,
                      items: startupCategories,
                      // ignore: deprecated_member_use
                      label: Get.find<StartupGlobalController>()
                          .currentStartup
                          .startupCategory,
                      onChanged: (val) {},
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Container(
                  height: 120,
                  child: TextFormField(
                    maxLines: 10,
                    controller: startupDescriptionController,
                    onEditingComplete: () {
                      StartupDataBase().updateStartupDescription(
                          startupDescriptionController.text);
                    },
                    decoration: InputDecoration(
                      labelText: "Description",
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 100,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    StartupDataBase()
                        .updateStartupUserName(startupUserNameController.text);
                    StartupDataBase()
                        .updateStartupName(startupNameController.text);
                    StartupDataBase().updateStartupRegisteredName(
                        startupRegNameController.text);
                    StartupDataBase()
                        .updateStartupPhoneNo(startupPhoneNoController.text);
                    StartupDataBase()
                        .updateStartupEmail(startupEmailController.text);
                    StartupDataBase().updateStartupLinkedinUrl(
                        startupLinkedinUrlController.text);
                    // StartupDataBase().updateStartupWebAppUrl(startupWebAppUrlController.text);
                    StartupDataBase()
                        .updateStartupCity(startupCityController.text);
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      primary: Theme.of(context).primaryColor),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
