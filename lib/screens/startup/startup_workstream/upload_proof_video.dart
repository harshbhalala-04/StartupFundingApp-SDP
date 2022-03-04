import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/proof_video_picker_controller.dart';
import 'package:flutter/material.dart';

class UploadProofVideoScreen extends StatefulWidget {
  const UploadProofVideoScreen({Key? key}) : super(key: key);

  @override
  State<UploadProofVideoScreen> createState() => _UploadProofVideoScreenState();
}

class _UploadProofVideoScreenState extends State<UploadProofVideoScreen> {
  // final ProofVideoPickerController proofVideoPickerController =
  //     Get.put(ProofVideoPickerController());
  @override
  Widget build(BuildContext context) {
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
        child: Container(
          width: 300,
          height: 300,
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
                      // proofVideoPickerController.pickVideo(context);
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
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: 150,
                    child: ElevatedButton(
                      onPressed: () {
                        // proofVideoPickerController.pickVideo(context);
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
      ),
    );
  }
}
