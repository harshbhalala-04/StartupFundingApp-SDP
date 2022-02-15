// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/widgets/custom_textformfield.dart';

class StartupEditProfileScreen extends StatelessWidget {
  StartupEditProfileScreen({Key? key}) : super(key: key);

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
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Name",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .userName
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Startup Name",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .startupName
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Startup Registered Name",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .regStartupName
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Phone No",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .phoneNo
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Email",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .email
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Website/App Url",
                  initialValue: "",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Linkedin Url",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .linkedinUrl
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "City",
                  initialValue: Get.find<StartupGlobalController>()
                      .currentStartup
                      .startupCity
                      .toString(),
                )),
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
                    initialValue: Get.find<StartupGlobalController>()
                        .currentStartup
                        .startupDescription
                        .toString(),
                    decoration: InputDecoration(
                      labelText: "Discription",
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
                  onPressed: () {},
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
