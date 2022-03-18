// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';

class UploadProofVideoScreen extends StatefulWidget {
  final String workStreamId;
  final String stageUid;

  UploadProofVideoScreen({required this.workStreamId, required this.stageUid});

  @override
  State<UploadProofVideoScreen> createState() => _UploadProofVideoScreenState();
}

class _UploadProofVideoScreenState extends State<UploadProofVideoScreen> {
  File? file;
  UploadTask? task;
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
      createAlertDialogue("Please upload your proof video.");
      return;
    }

    final fileName = p.basename(file!.path);
    final destination = '/proof_of_work/pof_video/$fileName';

    task = StartupDataBase.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    StartupDataBase()
        .uploadStageVideo(urlDownload, widget.workStreamId, widget.stageUid);
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? p.basename(file!.path) : 'No File selected';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Video",
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
          child: SingleChildScrollView(
        child: Container(
          width: 300,
          height: 350,
          padding: new EdgeInsets.all(10.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            elevation: 10,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: InkWell(
                    onTap: () {
                      selectFile();
                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Card(
                        elevation: 10,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                              child: Icon(
                                Icons.upload_sharp,
                                size: 60,
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                            SizedBox(height: 15),
                            Text(
                              "Upload Video Here",
                              style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: "Cabin",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  fileName,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Cabin"),
                )),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        Get.back();
                        uploadFile();
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
      )),
    );
  }
}
