// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/upload_work_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_doc.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_images.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_link.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_video.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';

class WorkProofScreen extends StatefulWidget {
  final String workStreamId;
  final String stageUid;
  final int index;
  WorkProofScreen(
      {required this.workStreamId,
      required this.stageUid,
      required this.index});

  @override
  State<WorkProofScreen> createState() => _WorkProofScreenState();
}

class _WorkProofScreenState extends State<WorkProofScreen> {
  final UploadWorkController uploadWorkController =
      Get.put(UploadWorkController());

  @override
  void initState() {
    uploadWorkController.fetchUploadedInfo(
        widget.workStreamId, widget.stageUid);
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
      body: Obx(
        () => uploadWorkController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Center(
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          "Upload Proof of Work for Stage ${widget.index + 1}",
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontFamily: "Cabin",
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(UploadProofImagesScreen(
                                    workStreamId: widget.workStreamId,
                                    stageUid: widget.stageUid));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: new EdgeInsets.all(10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 20, 0, 0),
                                        child: Icon(
                                          Icons.image,
                                          size: 40,
                                          color: Colors.white,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Images",
                                        style: TextStyle(
                                            fontFamily: "Cabin",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(UploadProofVideoScreen(
                                  workStreamId: widget.workStreamId,
                                  stageUid: widget.stageUid,
                                ));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: new EdgeInsets.all(10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Icon(
                                            Icons.video_collection,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                        "Video",
                                        style: TextStyle(
                                            fontFamily: "Cabin",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 25),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            InkWell(
                              onTap: () {
                                Get.to(UploadProofDocScreen(
                                  workStreamId: widget.workStreamId,
                                  stageId: widget.stageUid,
                                ));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: new EdgeInsets.all(10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Icon(
                                            Icons.document_scanner,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                        "Documents",
                                        style: TextStyle(
                                            fontFamily: "Cabin",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(UploadProofLinkScreen(
                                    workStreamId: widget.workStreamId,
                                    stageUid: widget.stageUid));
                              },
                              child: Container(
                                width: 150,
                                height: 150,
                                padding: new EdgeInsets.all(10.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  color: Theme.of(context).primaryColor,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 20, 0, 0),
                                          child: Icon(
                                            Icons.link,
                                            size: 40,
                                            color: Colors.white,
                                          )),
                                      SizedBox(height: 10),
                                      Text(
                                        "URL",
                                        style: TextStyle(
                                            fontFamily: "Cabin",
                                            fontSize: 20,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 40,
          width: 230,
          child: ElevatedButton(
            child: Text(
              'Submit Your Work',
              style: TextStyle(fontFamily: "Cabin", fontSize: 18),
            ),
            onPressed: () {
              if (uploadWorkController.isDocUploaded.value ||
                  uploadWorkController.isImgUploaded.value ||
                  uploadWorkController.isVideoUploaded.value ||
                  uploadWorkController.isUrlUploaded.value) {
                // Upload Data to Database to show to investors
                Get.back();
                StartupDataBase()
                    .submitStageProof(widget.workStreamId, widget.stageUid);
              } else {
                createAlertDialogue("Please Upload some proof before submit!");
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
