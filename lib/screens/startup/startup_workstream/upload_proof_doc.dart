// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/upload_work_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:http/http.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/pitch_deck_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:web3dart/web3dart.dart';
import 'package:path/path.dart' as p;

class UploadProofDocScreen extends StatefulWidget {
  final String workStreamId;
  final String stageId;
  UploadProofDocScreen({required this.workStreamId, required this.stageId});
  @override
  State<UploadProofDocScreen> createState() => _UploadProofDocScreenState();
}

class _UploadProofDocScreenState extends State<UploadProofDocScreen> {
  final UploadWorkController uploadWorkController =
      Get.put(UploadWorkController());

  File? file;
  UploadTask? task;

  checkData() {
    uploadFile();
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path;

    setState(() {
      file = File(path!);
    });
  }

  Future uploadFile() async {
    if (file == null) {
      createAlertDialogue("Please upload your pitch deck.");
      return;
    }

    final fileName = p.basename(file!.path);
    final destination = '/proof_of_work/pof_doc/$fileName';

    task = StartupDataBase.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    StartupDataBase().uploadStageDoc(urlDownload, widget.workStreamId, widget.stageId);
  }

  @override
  void initState() {
    // TODO: implement initState

    // uploadWorkController.fetchWorkImages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? p.basename(file!.path) : 'No File selected';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Documents",
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
      body: Center(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              SizedBox(height: 120),
              Container(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Upload Your Documents Here...",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Image.asset(
                "assets/upload.png",
                height: 68,
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                'Drag & Drop Files Here',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Cabin",
                  fontSize: 16,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                onPressed: () {
                  selectFile();
                },
                child: Text(
                  'Browse File',
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Cabin", fontSize: 16),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                  child: Text(
                fileName,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    fontFamily: "Cabin"),
              )),
              SizedBox(
                height: 5,
              ),
              task != null ? buildUploadStatus(task!) : Container(),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      uploadFile();
                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        primary: Theme.of(context).primaryColor),
                    child: Text(
                      "Upload",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
