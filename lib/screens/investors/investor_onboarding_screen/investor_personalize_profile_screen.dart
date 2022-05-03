// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/global.dart';
import 'package:startupfunding/screens/investors/investor_home_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

enum PreferInvest { LeadDeals, Group }
enum Mentor { Yes, No }

class InvestorPersonalizeProfileScreen extends StatefulWidget {
  const InvestorPersonalizeProfileScreen({Key? key}) : super(key: key);

  @override
  _InvestorPersonalizeProfileScreenState createState() =>
      _InvestorPersonalizeProfileScreenState();
}

class _InvestorPersonalizeProfileScreenState
    extends State<InvestorPersonalizeProfileScreen> {
  late List<Object?> expertiseAns;
  PreferInvest? preferInvest;
  Mentor? mentor;
  List<MultiSelectItem<String>> expertise = [
    MultiSelectItem("Advertising", "Advertising"),
    MultiSelectItem("Aerospace", "Aerospace"),
    MultiSelectItem("Agriculture", "Agriculture"),
    MultiSelectItem("AI", "AI"),
    MultiSelectItem(
      "Analytics",
      "Analytics",
    ),
    MultiSelectItem("AR/VR", "AR/VR"),
    MultiSelectItem("Architecture", "Architecture"),
    MultiSelectItem("Art & Photography", "Art & Photography"),
    MultiSelectItem("Automative", "Automative"),
    MultiSelectItem("Beauty", "Beauty"),
    MultiSelectItem("Big Data", "Big Data"),
    MultiSelectItem("Blockchain", "Blockchain"),
    MultiSelectItem("Careers", "Careers"),
    MultiSelectItem("Communication", "Communication"),
    MultiSelectItem("Computer Vision", "Computer Vision"),
    MultiSelectItem("Construction", "Construction"),
    MultiSelectItem("Consumer Goods", "Consumer Goods"),
    MultiSelectItem("Dating/Matrimonial", "Dating/Matrimonial"),
    MultiSelectItem("Defence", "Defence"),
    MultiSelectItem("Design", "Design"),
    MultiSelectItem("Education", "Education"),
    MultiSelectItem("Energy & Sustainability", "Energy & Sustainability"),
    MultiSelectItem("Enterprise Software", "Enterprise Software"),
    MultiSelectItem("Events", "Events"),
    MultiSelectItem("Fashion", "Fashion"),
    MultiSelectItem("FinTech", "FinTech"),
    MultiSelectItem("Food & Beverages", "Food & Beverages"),
    MultiSelectItem("Gaming", "Gaming"),
    MultiSelectItem("Gifting", "Gifting"),
    MultiSelectItem("Grocery", "Grocery"),
    MultiSelectItem("Hardware", "Hardware"),
    MultiSelectItem("Healthcare", "Healthcare"),
    MultiSelectItem("Human Resources", "Human Resources"),
    MultiSelectItem("Information/Tech", "Information/Tech"),
    MultiSelectItem("Internet of Things", "Internet of Things"),
    MultiSelectItem("IT Services", "IT Services"),
    MultiSelectItem("Legal", "Legal"),
    MultiSelectItem("Logistics", "Logistics"),
    MultiSelectItem("Manufacturing", "Manufacturing"),
    MultiSelectItem("Marketing", "Marketing"),
    MultiSelectItem("Media & Entertainment", "Media & Entertainment"),
    MultiSelectItem("Nanotechnology", "Nanotechnology"),
    MultiSelectItem("Networking", "Networking"),
    MultiSelectItem("Pets & Animals", "Pets & Animals"),
    MultiSelectItem("Printing", "Printing"),
    MultiSelectItem("Real Estate", "Real Estate"),
    MultiSelectItem("Retail", "Retail"),
    MultiSelectItem("Robotics", "Robotics"),
    MultiSelectItem("Safety", "Safety"),
    MultiSelectItem("Security", "Security"),
    MultiSelectItem("Services", "Services"),
    MultiSelectItem("Social Impact", "Social Impact"),
    MultiSelectItem("Social Network", "Social Network"),
    MultiSelectItem("Sports", "Sports"),
    MultiSelectItem("Storage", "Storage"),
    MultiSelectItem("Transportation", "Transportation"),
    MultiSelectItem("Travel & Tourism", "Travel & Tourism"),
  ];
  String preferInvestement = "";
  String mentorStartup = "";
  void checkData() {
    if (preferInvest == null) {
      createAlertDialogue("Please select your preference for investment");
    }
    if (mentor == null) {
      createAlertDialogue("Please select do you want to mentor startup or not");
    }
    if (PreferInvest.LeadDeals == preferInvest) {
      preferInvestement = "Lead Deals";
    } else if (PreferInvest.Group == preferInvest) {
      preferInvestement = "Group";
    }
    if (Mentor.Yes == mentor) {
      mentorStartup = "Yes";
    } else if (Mentor.No == mentor) {
      mentorStartup = "No";
    }
    fromSignup = true;
    Get.to(InvestorHomeScreen());
    InvestorDataBase().addInvestorPersonalizeInfo(
        expertiseAns, preferInvestement, mentorStartup);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: OnBoardingAppBarTitle(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          color: Colors.black,
          onPressed: () {
            Get.back();
          },
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
              'I have expertise in these sectors',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: "Cabin",
              ),
            ),
            SizedBox(
              height: 15,
            ),
            MultiSelectDialogField(
              items: expertise,
              title: Text(
                "Select",
                style: TextStyle(
                    fontFamily: "Cabin", fontSize: 18, color: Colors.black),
              ),
              selectedColor: Theme.of(context).primaryColor,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(40)),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 2,
                ),
              ),
              onConfirm: (results) {
                expertiseAns = results;
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "How do you prefer to invest?",
              style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  preferInvest = PreferInvest.LeadDeals;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: PreferInvest.LeadDeals,
                    groupValue: preferInvest,
                    onChanged: (PreferInvest? value) {
                      setState(() {
                        preferInvest = value!;
                      });
                    },
                  ),
                  Text(
                    'Lead Deals',
                    style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  preferInvest = PreferInvest.Group;
                });
              },
              child: Row(
                children: [
                  Radio(
                    value: PreferInvest.Group,
                    groupValue: preferInvest,
                    onChanged: (PreferInvest? value) {
                      setState(() {
                        preferInvest = value!;
                      });
                    },
                  ),
                  Text(
                    'Co-invest with a group',
                    style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Would you like to mentor startups?",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Cabin"),
            ),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      mentor = Mentor.Yes;
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                        value: Mentor.Yes,
                        groupValue: mentor,
                        onChanged: (Mentor? value) {
                          setState(() {
                            mentor = value!;
                          });
                        },
                      ),
                      Text(
                        'Yes',
                        style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      mentor = Mentor.No;
                    });
                  },
                  child: Row(
                    children: [
                      Radio(
                        value: Mentor.No,
                        groupValue: mentor,
                        onChanged: (Mentor? value) {
                          setState(() {
                            mentor = value!;
                          });
                        },
                      ),
                      Text(
                        'No',
                        style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}
