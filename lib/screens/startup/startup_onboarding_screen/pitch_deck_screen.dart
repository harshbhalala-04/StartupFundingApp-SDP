// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_home_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class PitchDeckScreen extends StatefulWidget {
  const PitchDeckScreen({Key? key}) : super(key: key);

  @override
  State<PitchDeckScreen> createState() => _PitchDeckScreenState();
}

class _PitchDeckScreenState extends State<PitchDeckScreen> {
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
    final destination = 'files/$fileName';

    task = StartupDataBase.uploadFile(destination, file!);
    setState(() {});

    if (task == null) return;
    
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    print('Download-Link: $urlDownload');

    StartupDataBase().addPitchDeckUrl(urlDownload);

    Get.to(StartupHomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final fileName = file != null ? p.basename(file!.path) : 'No File selected';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: OnBoardingAppBarTitle(),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Please share your pitch deck (To know more about your startup idea)',
              style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 60,
            ),
            Center(
              child: Image.asset(
                "assets/upload.png",
                height: 68,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: Text(
                'Drag & Drop Files Here',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "Cabin",
                  fontSize: 16,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
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
            ),
            Text(
              fileName,
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  fontFamily: "Cabin"),
            ),
            SizedBox(
              height: 5,
            ),
            task != null ? buildUploadStatus(task!) : Container()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(checkData: checkData),
    );
  }
}

Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
      stream: task.snapshotEvents,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final snap = snapshot.data!;
          final progress = snap.bytesTransferred / snap.totalBytes;
          final percentage = (progress * 100).toStringAsFixed(2);

          return Center(
            child: Text(
              '$percentage %',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Cabin"),
            ),
          );
        } else {
          return Container();
        }
      },
    );
