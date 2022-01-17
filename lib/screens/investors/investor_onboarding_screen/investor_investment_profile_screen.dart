// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_investment_profile_screen_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/screens/investors/investor_onboarding_screen/investor_personalize_profile_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

enum Invested { Yes, No }
enum AssetInfo { Yes, No }

class InvestorInvestmentProfileScreen extends StatefulWidget {
  @override
  State<InvestorInvestmentProfileScreen> createState() =>
      _InvestorInvestmentProfileScreenState();
}

class _InvestorInvestmentProfileScreenState
    extends State<InvestorInvestmentProfileScreen> {
  String? reply;

  Invested? investReply;
  AssetInfo? assetReply;
  List<String> choosenExp = [];

  final controller = Get.put(InvestorInvestmentProfileScreenController());

  List<String> bestDescribe = [
    "Business Owner",
    "Professional",
    "VC & PE Professional",
    "VC & PE Fund",
    "Angel Network",
    "Family Office",
    "Startup Founder",
    "Accelerator/Incubator",
    "Student",
    "Other"
  ];

  String? invest;
  String? asset;

  void checkData() {
    if (reply == null || reply == "") {
      createAlertDialogue("Please select category");
      return;
    } else if (investReply == null) {
      createAlertDialogue("Please select option for angel invested before.");
      return;
    } else if (assetReply == null) {
      createAlertDialogue("Please select if you have any other asset or not");
      return;
    }
    if (investReply == Invested.Yes) {
      invest = "Yes";
    } else if (investReply == Invested.No) {
      invest = "No";
    }

    if (assetReply == AssetInfo.Yes) {
      asset = "Yes";
    } else if (assetReply == AssetInfo.No) {
      asset = "No";
    }
    if (controller.option1.value) {
      choosenExp.add("You have invested in startups before");
    }
    if (controller.option2.value) {
      choosenExp.add(
          "You come from an entrepreneurial family or have been a founder/co-founder of a business venture family.");
    }
    if (controller.option3.value) {
      choosenExp.add("You have atleast 10 years of work experience.");
    }
    if (controller.option4.value) {
      choosenExp.add("None of the above");
    }
    Get.to(InvestorPersonalizeProfileScreen());
    InvestorDataBase()
        .addInvestorInvestmentDetails(invest!, reply!, choosenExp, asset!);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                'Select category for your project',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  fontFamily: "Cabin",
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  showSelectedItems: true,
                  items: bestDescribe,
                  // ignore: deprecated_member_use
                  label: "Select",
                  onChanged: (val) {
                    reply = val!;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Have you angel invested before?",
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
                        investReply = Invested.Yes;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: Invested.Yes,
                          groupValue: investReply,
                          onChanged: (Invested? value) {
                            setState(() {
                              investReply = value!;
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
                        investReply = Invested.No;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: Invested.No,
                          groupValue: investReply,
                          onChanged: (Invested? value) {
                            setState(() {
                              investReply = value!;
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
              SizedBox(
                height: 20,
              ),
              Text(
                "Help us understand your experience better",
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Obx(() => Row(
                    children: [
                      Checkbox(
                          value: controller.option1.value,
                          onChanged: (val) {
                            controller.option1.value = val!;
                          }),
                      Flexible(
                        child: Text(
                          "You have invested in startups before",
                          style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                        ),
                      )
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Obx(() => Row(
                    children: [
                      Checkbox(
                          value: controller.option2.value,
                          onChanged: (val) {
                            controller.option2.value = val!;
                          }),
                      Flexible(
                        child: Text(
                          "You come from an entrepreneurial family or have been a founder/co-founder of a business venture family.",
                          style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Obx(() => Row(
                    children: [
                      Checkbox(
                          value: controller.option3.value,
                          onChanged: (val) {
                            controller.option3.value = val!;
                          }),
                      Flexible(
                        child: Text(
                          "You have atleast 10 years of work experience.",
                          style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                        ),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Obx(() => Row(
                    children: [
                      Checkbox(
                          value: controller.option4.value,
                          onChanged: (val) {
                            controller.option4.value = val!;
                          }),
                      Text(
                        "None of the above",
                        style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                      ),
                    ],
                  )),
              SizedBox(
                height: 15,
              ),
              Text(
                "Do you have assets worth over INR 2 cr apart from your primary residence?",
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        assetReply = AssetInfo.Yes;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: AssetInfo.Yes,
                          groupValue: assetReply,
                          onChanged: (AssetInfo? value) {
                            setState(() {
                              assetReply = value!;
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
                        assetReply = AssetInfo.No;
                      });
                    },
                    child: Row(
                      children: [
                        Radio(
                          value: AssetInfo.No,
                          groupValue: assetReply,
                          onChanged: (AssetInfo? value) {
                            setState(() {
                              assetReply = value!;
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
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}
