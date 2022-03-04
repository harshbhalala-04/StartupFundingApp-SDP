import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';

class UploadProofDocScreen extends StatefulWidget {
  const UploadProofDocScreen({Key? key}) : super(key: key);

  @override
  State<UploadProofDocScreen> createState() => _UploadProofDocScreenState();
}

class _UploadProofDocScreenState extends State<UploadProofDocScreen> {
  File? file;
  UploadTask? task;

  // checkData() {
  //   uploadFile();
  // }

  // Future selectFile() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: false);

  //   if (result == null) return;
  //   final path = result.files.single.path;

  //   setState(() {
  //     file = File(path!);
  //   });
  // }

  // Future uploadFile() async {
  //   if (file == null) {
  //     createAlertDialogue("Please upload your document proof");
  //     return;
  //   }

  //   final fileName = p.basename(file!.path);
  //   final destination = 'proof_of_work/pow_doc/$fileName';

  //   task = StartupDataBase.uploadFile(destination, file!);
  //   setState(() {});

  //   if (task == null) return;

  //   final snapshot = await task!.whenComplete(() {});
  //   final urlDownload = await snapshot.ref.getDownloadURL();

  //   print('Download-Link: $urlDownload');

  //   StartupDataBase().addProofUrl(urlDownload);

  //   Get.to(UploadProofDocScreen());
  // }

  @override
  Widget build(BuildContext context) {
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
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                          shape: CircleBorder(),
                          color: Colors.white,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 37.5, 0, 0),
                                child: Icon(
                                  Icons.add_sharp,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                          shape: CircleBorder(),
                          color: Colors.white,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 37.5, 0, 0),
                                child: Icon(
                                  Icons.add_sharp,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      // checkData();
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
