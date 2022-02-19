// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_workstream/enter_stage_detail_screen.dart';

class CreateEditStageScreen extends StatefulWidget {
  final String workStreamId;
  CreateEditStageScreen({required this.workStreamId});

  @override
  State<CreateEditStageScreen> createState() => _CreateEditStageScreenState();
}

class _CreateEditStageScreenState extends State<CreateEditStageScreen> {
  final CreateEditStageController createEditStageController =
      Get.put(CreateEditStageController());

  @override
  void initState() {
    // TODO: implement initState
    // createEditStageController.stageList.value =
    //     Get.find<StartupGlobalController>().currentStartup.stage!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("___________________________");
    print(createEditStageController.stageList.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Create/Edit Stage",
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
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Get.find<CreateEditStageController>().isStageSubmitted.value
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
                                "  You have already submitted stages.",
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
                : Container(),
            Obx(() => ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: createEditStageController.stageList.length,
                itemBuilder: (ctx, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      createEditStageController
                                          .stageList[index].stageTitle,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Cabin",
                                        fontSize: 20,
                                      ),
                                    ),
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
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Cabin",
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                        createEditStageController.isVerified.value
                            ? (createEditStageController.isApproved[index]
                                ? Positioned(
                                    top: 10,
                                    right: 20,
                                    child: ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20),
                                          ),
                                        ),
                                      ),
                                      child: Text(
                                        "Approved",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            fontFamily: "Cabin",
                                            fontSize: 20),
                                      ),
                                    ),
                                  )
                                : Positioned(
                                    top: 10,
                                    right: 20,
                                    child: Column(
                                      children: [
                                        ElevatedButton(
                                          onPressed: () {},
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            "Rejected",
                                            style: TextStyle(
                                                color: Theme.of(context)
                                                    .primaryColor,
                                                fontFamily: "Cabin",
                                                fontSize: 20),
                                          ),
                                        ),
                                        ElevatedButton(
                                          child: Row(
                                            children: [
                                              Icon(Icons.edit),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                "Edit",
                                                style: TextStyle(
                                                    fontFamily: "Cabin",
                                                    fontSize: 18),
                                              ),
                                            ],
                                          ),
                                          onPressed: () {
                                            Get.to(EnterStageDetailScreen(
                                              fromEdit: true,
                                              stage: createEditStageController
                                                  .stageList[index],
                                              index: index,
                                              workStreamId: widget.workStreamId,
                                              stageIndex: index + 1,
                                            ));
                                          },
                                        ),
                                      ],
                                    ),
                                  ))
                            : Positioned(
                                top: 10,
                                right: 20,
                                child: ElevatedButton(
                                  child: Row(
                                    children: [
                                      Icon(Icons.edit),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Edit",
                                        style: TextStyle(
                                            fontFamily: "Cabin", fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  onPressed: () {
                                    Get.to(EnterStageDetailScreen(
                                      fromEdit: true,
                                      stage: createEditStageController
                                          .stageList[index],
                                      index: index,
                                      workStreamId: widget.workStreamId,
                                      stageIndex: index + 1,
                                    ));
                                  },
                                )),
                      ],
                    ),
                  );
                })),
            Get.find<CreateEditStageController>().isStageSubmitted.value
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add),
                            Text(
                              'Create Stage',
                              style:
                                  TextStyle(fontFamily: "Cabin", fontSize: 18),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Get.to(EnterStageDetailScreen(
                              fromEdit: false,
                              
                              workStreamId: widget.workStreamId,
                              stageIndex: createEditStageController.stageList ==
                                      null
                                  ? 1
                                  : createEditStageController.stageList.length +
                                      1));
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                  ),
            Get.find<CreateEditStageController>().isStageSubmitted.value
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      child: ElevatedButton(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Submit Stage For Review',
                              style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: 18,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                        onPressed: () {
                          StartupDataBase().submitStage(widget.workStreamId);
                          Get.back();
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 5,
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                        ),
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
