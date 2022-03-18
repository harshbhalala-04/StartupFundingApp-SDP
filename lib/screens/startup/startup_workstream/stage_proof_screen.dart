// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/upload_work_controller.dart';
import 'package:startupfunding/screens/startup/startup_workstream/create_edit_stage_screen.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/stage_proof_controllers.dart';
import 'package:startupfunding/screens/startup/startup_workstream/work_proof.dart';

class StageProofScreen extends StatefulWidget {
  final String workStreamId;
  StageProofScreen({required this.workStreamId});

  @override
  State<StageProofScreen> createState() => _StageProofScreenState();
}

class _StageProofScreenState extends State<StageProofScreen> {
  final StageProofController stageProofController =
      Get.put(StageProofController());

  final UploadWorkController uploadWorkController =
      Get.put(UploadWorkController());

  @override
  void initState() {
    stageProofController.fetchStage(widget.workStreamId);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Proof of Work",
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
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            SizedBox(height: 25),
            Obx(
              () => stageProofController.isLoading.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: stageProofController.stageList.length,
                      itemBuilder: (ctx, index) {
                        return InkWell(
                          onTap: () {
                            Get.to(() => WorkProofScreen(
                                workStreamId: widget.workStreamId,
                                stageUid: "stage " + (index + 1).toString(),
                                index: index));
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
                                        "Proof of Work for Stage ${index + 1}",
                                        style: TextStyle(
                                          fontFamily: "Cabin",
                                          fontSize: 20,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      trailing: (stageProofController
                                                  .stageList[index]
                                                  .uploadedProofDoc! ||
                                              stageProofController
                                                  .stageList[index]
                                                  .uploadedProofImg! ||
                                              stageProofController
                                                  .stageList[index]
                                                  .uploadedProofUrl! ||
                                              stageProofController
                                                  .stageList[index]
                                                  .uploadedProofVideo!)
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.green,
                                            )
                                          : Icon(
                                              Icons.done,
                                              color: Colors.white,
                                            )),
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
            )
          ])),
    );
  }
}
