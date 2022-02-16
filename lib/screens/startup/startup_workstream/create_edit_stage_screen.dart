// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/screens/startup/startup_workstream/enter_stage_detail_screen.dart';

class CreateEditStageScreen extends StatefulWidget {
  const CreateEditStageScreen({Key? key}) : super(key: key);

  @override
  State<CreateEditStageScreen> createState() => _CreateEditStageScreenState();
}

class _CreateEditStageScreenState extends State<CreateEditStageScreen> {
  final CreateEditStageController createEditStageController =
      Get.put(CreateEditStageController());

  @override
  void initState() {
    // TODO: implement initState
    createEditStageController.stageList.value =
        Get.find<StartupGlobalController>().currentStartup.stage!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Get.find<StartupGlobalController>().currentStartup.stage?.length);
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
                        Positioned(
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
                                  stage: createEditStageController.stageList[index],
                                  index: index,
                                ));
                              },
                            )),
                      ],
                    ),
                  );
                })),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                child: ElevatedButton(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add),
                      Text(
                        'Create Stage',
                        style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Get.to(EnterStageDetailScreen(fromEdit: false,));
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
              ),
            ),
            Padding(
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
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
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
