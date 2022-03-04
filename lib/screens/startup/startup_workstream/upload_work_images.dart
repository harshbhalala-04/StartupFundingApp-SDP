// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/upload_work_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class UploadWorkImagesScreen extends StatefulWidget {
  @override
  State<UploadWorkImagesScreen> createState() => _UploadWorkImagesScreenState();
}

class _UploadWorkImagesScreenState extends State<UploadWorkImagesScreen> {
  final UploadWorkController uploadWorkController =
      Get.put(UploadWorkController());

 

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Images",
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
                  "Upload Your Photos Here...",
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
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          uploadWorkController.pickImage(context, 0);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: new EdgeInsets.all(10.0),
                          child: Obx(
                            () => uploadWorkController.isUploadedImage[0]
                                ? Image(
                                    image: FileImage(
                                        uploadWorkController.choosenWorkImg[0]))
                                : Card(
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                         Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 37.5, 0, 0),
                                            child: Icon(
                                              Icons.add_sharp,
                                              size: 40,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ],
                                    )),
                          ),
                        ),
                      ),
                      // SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          uploadWorkController.pickImage(context, 1);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: new EdgeInsets.all(10.0),
                          child: Obx(
                            () => uploadWorkController.isUploadedImage[1]
                                ? Image(
                                    image: FileImage(
                                        uploadWorkController.choosenWorkImg[1]))
                                : Card(
                                    shape: CircleBorder(),
                                    color: Colors.white,
                                    elevation: 10,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 37.5, 0, 0),
                                            child: Icon(
                                              Icons.add_sharp,
                                              size: 40,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            )),
                                      ],
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          uploadWorkController.pickImage(context, 2);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: new EdgeInsets.all(10.0),
                          child: Obx(() => uploadWorkController
                                  .isUploadedImage[2]
                              ? Image(
                                  image: FileImage(
                                      uploadWorkController.choosenWorkImg[2]))
                              : Card(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 37.5, 0, 0),
                                        child: Icon(
                                          Icons.add_sharp,
                                          size: 40,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                        ),
                      ),
                      // SizedBox(width: 15),
                      InkWell(
                        onTap: () {
                          uploadWorkController.pickImage(context, 3);
                        },
                        child: Container(
                          width: 150,
                          height: 150,
                          padding: new EdgeInsets.all(10.0),
                          child: Obx(() => uploadWorkController
                                  .isUploadedImage[3]
                              ? Image(
                                  image: FileImage(
                                      uploadWorkController.choosenWorkImg[3]))
                              : Card(
                                  shape: CircleBorder(),
                                  color: Colors.white,
                                  elevation: 10,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              0, 37.5, 0, 0),
                                          child: Icon(
                                            Icons.add_sharp,
                                            size: 40,
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
                                    ],
                                  ),
                                )),
                        ),
                      ),
                    ],
                  ),
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
                      Get.back();
                      StartupDataBase()
                          .uploadWorkImg(uploadWorkController.choosenWorkImg);
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


