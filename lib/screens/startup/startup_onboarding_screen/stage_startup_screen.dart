// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/database.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/startup_city_screen.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

enum Stage {
  IdeaStage,
  ProofOfConcept,
  BetaLaunched,
  EarlyTraction,
  SteadyRevenues
}

class StartupStageScreen extends StatefulWidget {
  @override
  State<StartupStageScreen> createState() => _StartupStageScreenState();
}

class _StartupStageScreenState extends State<StartupStageScreen> {
  Stage? reply;

  checkData() {
    if (reply == Stage.IdeaStage) {
      DataBase().addStartupStage("Idea Stage");
    } else if (reply == Stage.BetaLaunched) {
      DataBase().addStartupStage("Beta Launched");
    } else if (reply == Stage.EarlyTraction) {
      DataBase().addStartupStage("Early Traction");
    } else if (reply == Stage.ProofOfConcept) {
      DataBase().addStartupStage("Proof of Concept");
    } else if (reply == Stage.SteadyRevenues) {
      DataBase().addStartupStage("Steady Revenues");
    }
    Get.to(StartupCityScreen());
  }

  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      reply = Stage.IdeaStage;
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
                'At Which stage is your startup?',
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
                    reply = Stage.IdeaStage;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Stage.IdeaStage,
                      groupValue: reply,
                      onChanged: (Stage? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('Idea Stage'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    reply = Stage.ProofOfConcept;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Stage.ProofOfConcept,
                      groupValue: reply,
                      onChanged: (Stage? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('Proof of Concept'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    reply = Stage.BetaLaunched;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Stage.BetaLaunched,
                      groupValue: reply,
                      onChanged: (Stage? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('Beta Launched'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    reply = Stage.EarlyTraction;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Stage.EarlyTraction,
                      groupValue: reply,
                      onChanged: (Stage? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('Early Traction'),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    reply = Stage.SteadyRevenues;
                  });
                },
                child: Row(
                  children: [
                    Radio(
                      value: Stage.SteadyRevenues,
                      groupValue: reply,
                      onChanged: (Stage? value) {
                        setState(() {
                          reply = value!;
                        });
                      },
                    ),
                    Text('Steady Revenues'),
                  ],
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
