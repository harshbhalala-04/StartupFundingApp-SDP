// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/verify_stage_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/models/stage_model.dart';

class StageDetailScreen extends StatelessWidget {
  final StageModel stage;
  final int stageIndex;
  final String workStreamId;
  final bool isValidated;
  final bool isApproved;
  StageDetailScreen(
      {required this.stage,
      required this.stageIndex,
      required this.workStreamId,
      required this.isValidated,
      required this.isApproved});

  @override
  Widget build(BuildContext context) {
    final TextEditingController feedBackController =
        new TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stage Detail",
          style: TextStyle(
              fontFamily: "Cabin",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isValidated
                ? (isApproved
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Card(
                              color: Colors.lightGreenAccent.shade200,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.done_outline_sharp,
                                    color: Colors.green.shade700,
                                  ),
                                  Text(
                                    " You have approved this stage.",
                                    style: TextStyle(
                                      color: Colors.green.shade700,
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: Card(
                              color: Theme.of(context).primaryColor,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.announcement_sharp,
                                    color: Colors.white,
                                  ),
                                  Text(
                                    "  You have rejected this stage.",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              )),
                        ),
                      ))
                : Container(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Title",
                          style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                              color: Theme.of(context).primaryColor),
                        ),
                        Text(
                          stage.stageTitle!,
                          style: TextStyle(
                            fontFamily: "Cabin",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Starting Date",
                            style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                        Text(
                            stage.startDay! +
                                "/" +
                                stage.startMonth! +
                                "/" +
                                stage.startYear!,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Ending Date",
                            style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                                color: Theme.of(context).primaryColor)),
                        Text(
                            stage.endDay! +
                                "/" +
                                stage.endMonth! +
                                "/" +
                                stage.endYear!,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Requested Funding",
                              style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor)),
                          Text(stage.stageFunding!,
                              style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Stage Description",
                  style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 20,
                      color: Theme.of(context).primaryColor)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(stage.stageDes!,
                  style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                  )),
            ),
            isValidated
                ? Container()
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                  child: AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                content: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Text(
                                        "Give Feedback for rejecting this stage",
                                        style: TextStyle(
                                            fontFamily: "Cabin", fontSize: 18),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      TextFormField(
                                        controller: feedBackController,
                                        decoration: InputDecoration(
                                            hintText: "Enter Here...",
                                            border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5)),
                                            )),
                                        maxLength: 100,
                                        maxLines: 5,
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                          elevation: 5,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20),
                                            ),
                                          ),
                                        ),
                                        onPressed: () {
                                          Get.find<VerifyStageController>()
                                                  .isValidated[stageIndex - 1] =
                                              true;
                                          Get.find<VerifyStageController>()
                                                  .isApproved[stageIndex - 1] =
                                              false;
                                          InvestorDataBase().rejectStage(
                                              stageIndex,
                                              workStreamId,
                                              feedBackController.text);
                                          Get.back();
                                          Get.back();
                                        },
                                        child: Text(
                                          "  Submit  ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Cabin",
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ));
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Reject",
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: "Cabin",
                                fontSize: 18),
                          ),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                        ),
                        onPressed: () {
                          InvestorDataBase()
                              .approveStage(stageIndex, workStreamId);
                          Get.find<VerifyStageController>()
                              .isValidated[stageIndex - 1] = true;
                          Get.find<VerifyStageController>()
                              .isApproved[stageIndex - 1] = true;
                          Get.back();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            "Approve",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Cabin",
                                fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
          ],
        )),
      ),
    );
  }
}
