// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/verify_submitted_stage_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/screens/investors/investor_workstream/view_doc_screen.dart';
import 'package:startupfunding/screens/investors/investor_workstream/view_photo_screen.dart';
import 'package:startupfunding/screens/investors/investor_workstream/view_url_screen.dart';
import 'package:startupfunding/screens/investors/investor_workstream/view_video_screen.dart';
import 'package:startupfunding/widgets/custom_card.dart';
import 'package:startupfunding/widgets/stage_proof_card.dart';

class SingleStageVerifyOptionScreen extends StatefulWidget {
  final String workStreamId;
  final String stageId;
  final int index;
  SingleStageVerifyOptionScreen(
      {required this.workStreamId, required this.stageId, required this.index});

  @override
  State<SingleStageVerifyOptionScreen> createState() =>
      _SingleStageVerifyOptionScreenState();
}

class _SingleStageVerifyOptionScreenState
    extends State<SingleStageVerifyOptionScreen> {
  final VerifySubmittedStageController verifySubmittedStageController =
      Get.put(VerifySubmittedStageController());

  @override
  void initState() {
    // TODO: implement initState
    verifySubmittedStageController.fetchUploadedDocuments(
        widget.workStreamId, widget.stageId);
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
      body: Obx(() => verifySubmittedStageController.fetchDocLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                InkWell(
                    onTap: () {
                      Get.to(ViewPhotoScreen(
                          photos: verifySubmittedStageController.photosList));
                    },
                    child:
                        StageProofCard(iconData: Icons.image, title: "Images")),
                InkWell(
                    onTap: () {
                      Get.to(ViewVideoScreen(
                        videoUrl: verifySubmittedStageController.video,
                      ));
                    },
                    child: StageProofCard(
                        iconData: Icons.video_collection, title: "Video")),
                InkWell(
                    onTap: () {
                      Get.to(ViewDocScreen(
                        docUrl: verifySubmittedStageController.document,
                      ));
                    },
                    child: StageProofCard(
                        iconData: Icons.document_scanner, title: "Document")),
                InkWell(
                    onTap: () {
                      Get.to(ViewUrlScreen(
                          url: verifySubmittedStageController.url));
                    },
                    child: StageProofCard(iconData: Icons.link, title: "URL")),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.find<VerifySubmittedStageController>()
                            .rejectStageStatus[widget.index] = true;
                        Get.find<VerifySubmittedStageController>()
                            .pendingStageStatus[widget.index] = false;
                        Get.back();
                        InvestorDataBase().verificationRejected(
                            widget.workStreamId, widget.stageId);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      child: Text(
                        "  Reject  ",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 20,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.find<VerifySubmittedStageController>()
                            .approveStageStatus[widget.index] = true;
                        Get.find<VerifySubmittedStageController>()
                            .pendingStageStatus[widget.index] = false;
                        Get.back();
                        InvestorDataBase().verificationApproved(
                            widget.workStreamId, widget.stageId);
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 5,
                        primary: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                      ),
                      child: Text(
                        "  Approve  ",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            )),
    );
  }
}
