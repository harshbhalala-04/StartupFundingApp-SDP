// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/verify_submitted_stage_controller.dart';
import 'package:startupfunding/screens/investors/investor_workstream/single_stage_verify_option_screen.dart';

class VerifySubmittedStageScreen extends StatefulWidget {
  final String workStreamId;

  VerifySubmittedStageScreen({
    required this.workStreamId,
  });

  @override
  State<VerifySubmittedStageScreen> createState() =>
      _VerifySubmittedStageScreenState();
}

class _VerifySubmittedStageScreenState
    extends State<VerifySubmittedStageScreen> {
  final VerifySubmittedStageController verifySubmittedStageController =
      Get.put(VerifySubmittedStageController());
  @override
  void initState() {
    // TODO: implement initState
    verifySubmittedStageController.fetchAllStages(widget.workStreamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify submitted stage",
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
      body: Obx(
        () => verifySubmittedStageController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: verifySubmittedStageController.stageList.length,
                itemBuilder: (context, index) {
                  if (verifySubmittedStageController.stageList.length == 0) {
                    return Center(
                      child: Image(image: AssetImage("assets/not_found.jpeg")),
                    );
                  } else {
                    return InkWell(
                      onTap: () {
                        Get.to(SingleStageVerifyOptionScreen(
                          stageId: verifySubmittedStageController
                              .stageList[index].stageUid!,
                          workStreamId: widget.workStreamId,
                          index: index,
                        ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Container(
                          height: 80,
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            child: Center(
                              child: ListTile(
                                  title: Text(
                                    "Proof of Work for ${verifySubmittedStageController.stageList[index].stageTitle}",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 20,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  trailing: Obx(
                                    () => verifySubmittedStageController
                                            .pendingStageStatus[index]
                                        ? Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : (verifySubmittedStageController
                                                .approveStageStatus[index]
                                            ? Icon(
                                                Icons.done,
                                                color: Colors.green,
                                              )
                                            : (verifySubmittedStageController
                                                    .rejectStageStatus[index]
                                                ? Icon(
                                                    Icons.error,
                                                    color: Colors.red,
                                                  )
                                                : Icon(
                                                    Icons.error,
                                                    color: Colors.white,
                                                  ))),
                                  )),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
      ),
    );
  }
}
