// ignore_for_file: prefer_const_constructors

import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/verify_stage_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/screens/investors/investor_workstream/payment_screen.dart';

class InvestorStageRequestScreen extends StatefulWidget {
  final String workStreamId;
  InvestorStageRequestScreen({required this.workStreamId});

  @override
  _InvestorStageRequestScreenState createState() =>
      _InvestorStageRequestScreenState();
}

class _InvestorStageRequestScreenState
    extends State<InvestorStageRequestScreen> {
  final VerifyStageController verifyStageController =
      Get.put(VerifyStageController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Stage Request",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Cabin",
              fontSize: 20),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: ListView.builder(
          itemCount: verifyStageController.stage.length,
          itemBuilder: (ctx, index) {
            print(verifyStageController.stage[index].stageTitle);
            print(verifyStageController.stage[index].startDay);
            print(verifyStageController.stage[index].endDay);
            print(verifyStageController.stage[index].startMonth);
            print(verifyStageController.stage[index].startYear);
            print(verifyStageController.stage[index].endMonth);
            print(verifyStageController.stage[index].endYear);
            print(verifyStageController.stage[index].stageDes);
            return verifyStageController.isApprovedRequest[index] ||
                    verifyStageController.isPendingRequest[index]
                ? Padding(
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
                              verifyStageController.stage[index].stageTitle,
                              style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                              ),
                            ),
                            collapsed: Text(
                              verifyStageController.stage[index].startDay +
                                  "/" +
                                  verifyStageController
                                      .stage[index].startMonth +
                                  "/" +
                                  verifyStageController.stage[index].startYear +
                                  " - " +
                                  verifyStageController.stage[index].endDay +
                                  "/" +
                                  verifyStageController.stage[index].endMonth +
                                  "/" +
                                  verifyStageController.stage[index].endYear,
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
                                  verifyStageController.stage[index].startDay +
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
                                  verifyStageController.stage[index].stageDes,
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
                                  "Raised Funding: ${verifyStageController.stage[index].stageFunding}",
                                  style: TextStyle(
                                      fontFamily: "Cabin", fontSize: 18),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Obx(() => verifyStageController
                                            .isPendingRequest[index]
                                        ? ElevatedButton(
                                            onPressed: () {
                                              verifyStageController
                                                      .isPendingRequest[index] =
                                                  false;
                                              verifyStageController
                                                      .isApprovedRequest[
                                                  index] = false;
                                              InvestorDataBase()
                                                  .rejectStageFunding(
                                                      widget.workStreamId,
                                                      verifyStageController
                                                          .stage[index]
                                                          .stageTitle);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            child: Text(
                                              "Reject",
                                              style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: "Cabin",
                                                fontSize: 18,
                                              ),
                                            ))
                                        : Container()),
                                    Obx(
                                      () => verifyStageController
                                              .isPendingRequest[index]
                                          ? SizedBox(width: 10)
                                          : Container(),
                                    ),
                                    Obx(() => verifyStageController
                                                .isApprovedRequest[index] ||
                                            !verifyStageController
                                                .isPendingRequest[index]
                                        ? Container()
                                        : ElevatedButton(
                                            onPressed: () {
                                              if (verifyStageController
                                                  .isApprovedRequest[index]) {
                                              } else {
                                                // verifyStageController
                                                //         .isApprovedRequest[
                                                //     index] = true;
                                                verifyStageController
                                                        .isPendingRequest[
                                                    index] = false;
                                                verifyStageController
                                                        .isApprovedRequest[
                                                    index] = true;
                                                Get.to(PaymentScreen(
                                                    workStreamId:
                                                        widget.workStreamId,
                                                    stageId:
                                                        verifyStageController
                                                            .stage[index]
                                                            .stageUid,
                                                    fundingAmount:
                                                        verifyStageController
                                                            .stage[index]
                                                            .stageFunding));
                                              }
                                            },
                                            style: ElevatedButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(10),
                                                ),
                                              ),
                                            ),
                                            child: verifyStageController
                                                    .isApprovedRequest[index]
                                                ? Text(
                                                    "Approved",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontFamily: "Cabin",
                                                      fontSize: 18,
                                                    ),
                                                  )
                                                : verifyStageController
                                                        .isPendingRequest[index]
                                                    ? Text(
                                                        "Accept",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: "Cabin",
                                                          fontSize: 18,
                                                        ),
                                                      )
                                                    : Container(),
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
                  )
                : Container();
          }),
    );
  }
}
