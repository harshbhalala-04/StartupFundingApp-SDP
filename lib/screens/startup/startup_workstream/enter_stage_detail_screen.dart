// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/enter_stage_detail_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/models/stage_model.dart';
import 'package:startupfunding/models/startup_model.dart';
import 'package:startupfunding/screens/startup/startup_workstream/create_edit_stage_screen.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class EnterStageDetailScreen extends StatefulWidget {
  final stage;
  final index;
  final bool fromEdit;
  final String workStreamId;
  final int stageIndex;

  EnterStageDetailScreen(
      {required this.fromEdit,
      this.stage,
      this.index,
      required this.workStreamId,
      required this.stageIndex});

  @override
  State<EnterStageDetailScreen> createState() => _EnterStageDetailScreenState();
}

class _EnterStageDetailScreenState extends State<EnterStageDetailScreen> {
  TextEditingController stageTitleController = new TextEditingController();

  TextEditingController stageDesController = new TextEditingController();

  TextEditingController stageFundingController = new TextEditingController();

  final EnterStageDetailController enterStageDetailController =
      Get.put(EnterStageDetailController());

  @override
  void initState() {
    // TODO: implement initState
    if (widget.fromEdit) {
      stageTitleController.text = widget.stage.stageTitle;
      stageDesController.text = widget.stage.stageDes;
      stageFundingController.text = widget.stage.stageFunding;
      enterStageDetailController.startDay.value = widget.stage.startDay;
      enterStageDetailController.startMonth.value = widget.stage.startMonth;
      enterStageDetailController.startYear.value = widget.stage.startYear;
      enterStageDetailController.endDay.value = widget.stage.endDay;
      enterStageDetailController.endMonth.value = widget.stage.endMonth;
      enterStageDetailController.endYear.value = widget.stage.endYear;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OnBoardingAppBarTitle(),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.fromEdit &&
                      Get.find<CreateEditStageController>().isApproved.length >=
                          1
                  ? Get.find<CreateEditStageController>()
                          .isApproved[widget.index]
                      ? Container()
                      : Text(
                          'Investor Feedback',
                          style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        )
                  : Container(),
              widget.fromEdit &&
                      Get.find<CreateEditStageController>().isApproved.length >=
                          1
                  ? Get.find<CreateEditStageController>()
                          .isApproved[widget.index]
                      ? Container()
                      : Text(
                          Get.find<CreateEditStageController>()
                              .feedBackList[widget.index],
                          style: TextStyle(
                            fontFamily: "Cabin",
                            fontSize: 20,
                          ),
                        )
                  : Container(),
              widget.fromEdit &&
                      Get.find<CreateEditStageController>().isApproved.length >=
                          1
                  ? Get.find<CreateEditStageController>()
                          .isApproved[widget.index]
                      ? Container()
                      : SizedBox(
                          height: 30,
                        )
                  : Container(),
              Text(
                'Enter Stage Title',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: stageTitleController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter Stage starting date",
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Container(
                      width: 50,
                      child: Obx(() => (TextField(
                            onTap: () {
                              enterStageDetailController.showDatePickerDailog(
                                  context, "Start");
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText: enterStageDetailController
                                          .startDay.value ==
                                      ''
                                  ? "DD"
                                  : enterStageDetailController.startDay.value,
                              border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(width: 2),
                              ),
                            ),
                          ))),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Container(
                    width: 60,
                    child: Obx(() => (TextField(
                          onTap: () {
                            enterStageDetailController.showDatePickerDailog(
                                context, "Start");
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText: enterStageDetailController
                                        .startMonth.value ==
                                    ''
                                ? "MM"
                                : enterStageDetailController.startMonth.value,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ))),
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Container(
                    width: 80,
                    child: Obx(() => (TextField(
                          onTap: () {
                            enterStageDetailController.showDatePickerDailog(
                                context, "Start");
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText:
                                enterStageDetailController.startYear.value == ''
                                    ? "YYYY"
                                    : enterStageDetailController
                                        .startYear.value,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ))),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today_rounded),
                    onPressed: () {
                      enterStageDetailController.showDatePickerDailog(
                          context, "Start");
                    },
                    color: Theme.of(context).primaryColor,
                    iconSize: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter Stage ending date",
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Flexible(
                    child: Container(
                      width: 50,
                      child: Obx(() => (TextField(
                            onTap: () {
                              enterStageDetailController.showDatePickerDailog(
                                  context, "End");
                            },
                            readOnly: true,
                            decoration: InputDecoration(
                              hintText:
                                  enterStageDetailController.endDay.value == ''
                                      ? "DD"
                                      : enterStageDetailController.endDay.value,
                              border: OutlineInputBorder(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(width: 2),
                              ),
                            ),
                          ))),
                    ),
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Container(
                    width: 60,
                    child: Obx(() => (TextField(
                          onTap: () {
                            enterStageDetailController.showDatePickerDailog(
                                context, "End");
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText:
                                enterStageDetailController.endMonth.value == ''
                                    ? "MM"
                                    : enterStageDetailController.endMonth.value,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ))),
                  )),
                  SizedBox(
                    width: 16,
                  ),
                  Flexible(
                      child: Container(
                    width: 80,
                    child: Obx(() => (TextField(
                          onTap: () {
                            enterStageDetailController.showDatePickerDailog(
                                context, "End");
                          },
                          readOnly: true,
                          decoration: InputDecoration(
                            hintText:
                                enterStageDetailController.endYear.value == ''
                                    ? "YYYY"
                                    : enterStageDetailController.endYear.value,
                            border: OutlineInputBorder(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(width: 2),
                            ),
                          ),
                        ))),
                  )),
                  SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.calendar_today_rounded),
                    onPressed: () {
                      enterStageDetailController.showDatePickerDailog(
                          context, "End");
                    },
                    color: Theme.of(context).primaryColor,
                    iconSize: 30,
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Enter Description for your stage",
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 8.0,
                  top: 8.0,
                  right: 8.0,
                ),
                child: TextField(
                  controller: stageDesController,
                  maxLines: 10,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(30)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                  maxLength: 100,
                ),
              ),
              Text(
                'Enter Required Funding amount (in Lakhs)',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: stageFundingController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Submit',
                  style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                ),
              ],
            ),
            onPressed: () {
              Get.back();
              Get.off(CreateEditStageScreen(
                workStreamId: widget.workStreamId,
              ));
              Map<String, dynamic> stage = {
                "stageTitle": stageTitleController.text,
                "stageDes": stageDesController.text,
                "startDay": enterStageDetailController.startDay.value,
                "startMonth": enterStageDetailController.startMonth.value,
                "startYear": enterStageDetailController.startYear.value,
                "endDay": enterStageDetailController.endDay.value,
                "endMonth": enterStageDetailController.endMonth.value,
                "endYear": enterStageDetailController.endYear.value,
                "stageFunding": stageFundingController.text
              };
              if (widget.fromEdit) {
                Get.find<CreateEditStageController>().stageList[widget.index] =
                    StageModel(
                        stageDes: stageDesController.text,
                        endDay: enterStageDetailController.endDay.value,
                        endMonth: enterStageDetailController.endMonth.value,
                        endYear: enterStageDetailController.endYear.value,
                        startDay: enterStageDetailController.startDay.value,
                        startMonth: enterStageDetailController.startMonth.value,
                        startYear: enterStageDetailController.startYear.value,
                        stageFunding: stageFundingController.text,
                        stageTitle: stageTitleController.text);
              } else {
                Get.find<CreateEditStageController>().stageList.add(StageModel(
                    stageDes: stageDesController.text,
                    endDay: enterStageDetailController.endDay.value,
                    endMonth: enterStageDetailController.endMonth.value,
                    endYear: enterStageDetailController.endYear.value,
                    startDay: enterStageDetailController.startDay.value,
                    startMonth: enterStageDetailController.startMonth.value,
                    startYear: enterStageDetailController.startYear.value,
                    stageFunding: stageFundingController.text,
                    stageTitle: stageTitleController.text));
              }

              if (widget.fromEdit) {
                StartupDataBase().editStageDetails(stage, widget.index,
                    widget.stageIndex.toString(), widget.workStreamId);
              } else {
                StartupDataBase().addStageDetails(
                    stage, widget.workStreamId, widget.stageIndex.toString());
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
            ),
          ),
        ),
      ),
    );
  }
}
