// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';

class StartupRequestStageScreen extends StatefulWidget {
  final String workStreamId;
  StartupRequestStageScreen({required this.workStreamId});

  @override
  State<StartupRequestStageScreen> createState() =>
      _StartupRequestStageScreenState();
}

class _StartupRequestStageScreenState extends State<StartupRequestStageScreen> {
  final CreateEditStageController createEditStageController =
      Get.put(CreateEditStageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Request Stage",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: !createEditStageController.isVerified.value
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      width: 150,
                      height: 150,
                      image: AssetImage("assets/waiting.png"),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your stages haven't been evaluated yet so please wait for to evaluate all stages from investor!",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.builder(
              itemCount: createEditStageController.stageList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpandablePanel(
                          header: Text(
                            createEditStageController
                                .stageList[index].stageTitle,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                            ),
                          ),
                          collapsed: Text(
                            createEditStageController
                                    .stageList[index].startDay +
                                "/" +
                                createEditStageController
                                    .stageList[index].startMonth +
                                "/" +
                                createEditStageController
                                    .stageList[index].startYear +
                                " - " +
                                createEditStageController
                                    .stageList[index].endDay +
                                "/" +
                                createEditStageController
                                    .stageList[index].endMonth +
                                "/" +
                                createEditStageController
                                    .stageList[index].endYear,
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 17,
                            ),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                createEditStageController
                                        .stageList[index].startDay +
                                    "/" +
                                    createEditStageController
                                        .stageList[index].startMonth +
                                    "/" +
                                    createEditStageController
                                        .stageList[index].startYear +
                                    " - " +
                                    createEditStageController
                                        .stageList[index].endDay +
                                    "/" +
                                    createEditStageController
                                        .stageList[index].endMonth +
                                    "/" +
                                    createEditStageController
                                        .stageList[index].endYear,
                                softWrap: true,
                                style: TextStyle(
                                    fontFamily: "Cabin",
                                    fontSize: 17,
                                    color: Colors.grey),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                createEditStageController
                                    .stageList[index].stageDes,
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Raised Funding: ${createEditStageController.stageList[index].stageFunding}",
                                style: TextStyle(
                                    fontFamily: "Cabin", fontSize: 18),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Obx(() => ElevatedButton(
                                        onPressed: () {
                                          if (createEditStageController
                                                  .pendingRequest[index] ||
                                              createEditStageController
                                                  .approvedRequest[index]) {
                                          } else {
                                            if (index == 0) {
                                              createEditStageController
                                                  .pendingRequest[index] = true;
                                              StartupDataBase().addRequestStage(
                                                  index + 1,
                                                  widget.workStreamId);
                                            } else {
                                              if (createEditStageController
                                                      .verificationApproved[
                                                  index - 1]) {
                                                createEditStageController
                                                        .pendingRequest[index] =
                                                    true;
                                                StartupDataBase()
                                                    .addRequestStage(index + 1,
                                                        widget.workStreamId);
                                              } else {
                                                createAlertDialogue(
                                                    "Please first complete your previous stage or If you have already submitted proof then you can wait for some time!");
                                              }
                                            }
                                          }
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:
                                              Theme.of(context).primaryColor,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                        ),
                                        child: createEditStageController
                                                .approvedRequest[index]
                                            ? Text(
                                                "Approved",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: "Cabin",
                                                  fontSize: 18,
                                                ),
                                              )
                                            : createEditStageController
                                                    .pendingRequest[index]
                                                ? Text(
                                                    "Request Pending",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Cabin",
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                : Text(
                                                    "Request",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Cabin",
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                      )),
                                ],
                              ),
                            ],
                          ),
                          theme: ExpandableThemeData(
                            iconColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
