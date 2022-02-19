// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/verify_stage_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/screens/investors/investor_workstream/stage_detail_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';

class VerifyStageScreen extends StatelessWidget {
  final String workStreamId;

  VerifyStageScreen({required this.workStreamId});

  final VerifyStageController verifyStageController =
      Get.put(VerifyStageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Verify Stage",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Cabin",
              fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: [
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: verifyStageController.stage.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: EdgeInsets.all(16),
                    child: InkWell(
                      onTap: () {
                        Get.to(StageDetailScreen(
                            stage: verifyStageController.stage[index],
                            stageIndex: index + 1,
                            workStreamId: workStreamId,
                            isValidated:
                                verifyStageController.isValidated[index],
                            isApproved:
                                verifyStageController.isApproved[index]));
                      },
                      child: Stack(
                        children: [
                          Container(
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                color: Theme.of(context).primaryColor,
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        verifyStageController
                                            .stage[index].stageTitle,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Cabin",
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        verifyStageController
                                                .stage[index].startDay +
                                            "/" +
                                            verifyStageController
                                                .stage[index].startMonth +
                                            "/" +
                                            verifyStageController
                                                .stage[index].startYear +
                                            " - " +
                                            verifyStageController
                                                .stage[index].endDay +
                                            "/" +
                                            verifyStageController
                                                .stage[index].endMonth +
                                            "/" +
                                            verifyStageController
                                                .stage[index].endYear,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Cabin",
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )),
                          verifyStageController.isValidated[index]
                              ? Positioned(
                                  top: 10,
                                  right: 20,
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      verifyStageController.isValidated[index]
                                          ? (verifyStageController
                                                  .isApproved[index]
                                              ? "Approved"
                                              : "Rejected")
                                          : "",
                                      style: TextStyle(
                                        color: Theme.of(context).primaryColor,
                                        fontFamily: "Cabin",
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                )
                              : Container(),
                        ],
                      ),
                    ),
                  );
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (verifyStageController.isSubmitApplyable.value) {
                      InvestorDataBase().addStageVerify(workStreamId, "Investor has validated all the stages.");
                      Get.back();
                    } else {
                      createAlertDialogue(
                          "Please validate all stages before submit your response");
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                  ),
                  child: Text(
                    "Submit Your Response",
                    style: TextStyle(
                        color: Colors.white, fontFamily: "Cabin", fontSize: 18),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
