// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/startup_description.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class StartupCategoryScreen extends StatelessWidget {
  String categoryAns = "";
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

  void checkData() {
    if (categoryAns == "") {
      createAlertDialogue("Please select category for your Startup");
    } else {
      Get.to(StartupDescriptionScreen());
      StartupDataBase().addStartupCategory(categoryAns);
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
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              'Whats Your Education?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
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
                label: "Select",
                onChanged: (val) {
                  categoryAns = val!;
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}
