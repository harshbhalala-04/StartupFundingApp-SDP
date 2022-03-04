import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_doc.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_images.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_link.dart';
import 'package:startupfunding/screens/startup/startup_workstream/upload_proof_video.dart';

class WorkProofScreen extends StatelessWidget {
  final String workStreamId;
  final int index;
  WorkProofScreen({required this.workStreamId, required this.index});

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
        body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                  alignment: Alignment.bottomLeft,
                  child: Text(
                    "Upload Proof of Work for Stage ${index + 1}",
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
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(UploadProofImagesScreen(
                                workStreamId: workStreamId,
                                stageUid: "stage " + (index + 1).toString()));
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
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
                        SizedBox(width: 25),
                        InkWell(
                          onTap: () {
                            Get.to(UploadProofVideoScreen());
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Icon(
                                      Icons.video_collection,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
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
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Get.to(UploadProofDocScreen());
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Icon(
                                      Icons.document_scanner,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
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
                        SizedBox(width: 25),
                        InkWell(
                          onTap: () {
                            Get.to(UploadProofLinkScreen(
                                workStreamId: workStreamId,
                                stageUid: "stage " + (index + 1).toString()));
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
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 0, 0),
                                    child: Icon(
                                      Icons.link,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ),
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
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
