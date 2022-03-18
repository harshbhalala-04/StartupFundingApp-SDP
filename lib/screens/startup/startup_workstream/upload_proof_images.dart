// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:startupfunding/controllers/startup_controllers/proof_image_picker_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:get/get.dart';

class UploadProofImagesScreen extends StatefulWidget {
  final String workStreamId;
  final String stageUid;
  UploadProofImagesScreen({required this.workStreamId, required this.stageUid});
  @override
  State<UploadProofImagesScreen> createState() =>
      _UploadProofImagesScreenState();
}

class _UploadProofImagesScreenState extends State<UploadProofImagesScreen> {
  final ProofImagePickerController proofImagePickerController =
      Get.put(ProofImagePickerController());

  @override
  void initState() {
    proofImagePickerController.fetchImage(widget.stageUid, widget.workStreamId);
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
              Obx(() => proofImagePickerController.loadInit.value
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () {
                              proofImagePickerController.pickImage(context, 0);
                            },
                            child: Obx(() => proofImagePickerController
                                    .uploadedProofImg.value
                                ? (proofImagePickerController.networkImg[0] !=
                                        ""
                                    ? Container(
                                        child: Image(
                                          width: 150,
                                          height: 150,
                                          image: CachedNetworkImageProvider(
                                              proofImagePickerController
                                                  .networkImg[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
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
                                                    const EdgeInsets.fromLTRB(
                                                        0, 37.5, 0, 0),
                                                child: Icon(
                                                  Icons.add_sharp,
                                                  size: 40,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                : proofImagePickerController.isUploadedImage[0]
                                    ? Container(
                                        child: Image(
                                          width: 150,
                                          height: 150,
                                          image: FileImage(
                                              proofImagePickerController
                                                  .choosenImage[0]),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
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
                                                    const EdgeInsets.fromLTRB(
                                                        0, 37.5, 0, 0),
                                                child: Icon(
                                                  Icons.add_sharp,
                                                  size: 40,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                          ),
                          InkWell(
                              onTap: () {
                                proofImagePickerController.pickImage(
                                    context, 1);
                              },
                              child: Obx(() => proofImagePickerController
                                      .uploadedProofImg.value
                                  ? (proofImagePickerController.networkImg[1] !=
                                          ""
                                      ? Container(
                                          child: Image(
                                            width: 150,
                                            height: 150,
                                            image: CachedNetworkImageProvider(
                                                proofImagePickerController
                                                    .networkImg[1]),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
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
                                                      const EdgeInsets.fromLTRB(
                                                          0, 37.5, 0, 0),
                                                  child: Icon(
                                                    Icons.add_sharp,
                                                    size: 40,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  : proofImagePickerController
                                          .isUploadedImage[1]
                                      ? Container(
                                          child: Image(
                                            width: 150,
                                            height: 150,
                                            image: FileImage(
                                                proofImagePickerController
                                                    .choosenImage[1]),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
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
                                                      const EdgeInsets.fromLTRB(
                                                          0, 37.5, 0, 0),
                                                  child: Icon(
                                                    Icons.add_sharp,
                                                    size: 40,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                        ],
                      ),
                    )),
              // SizedBox(height: 25),
              Obx(() => proofImagePickerController.loadInit.value
                  ? Container()
                  : Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                proofImagePickerController.pickImage(
                                    context, 2);
                              },
                              child: Obx(() => proofImagePickerController
                                      .uploadedProofImg.value
                                  ? (proofImagePickerController.networkImg[2] !=
                                          ""
                                      ? Container(
                                          child: Image(
                                            width: 150,
                                            height: 150,
                                            image: CachedNetworkImageProvider(
                                                proofImagePickerController
                                                    .networkImg[2]),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
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
                                                      const EdgeInsets.fromLTRB(
                                                          0, 37.5, 0, 0),
                                                  child: Icon(
                                                    Icons.add_sharp,
                                                    size: 40,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  : proofImagePickerController
                                          .isUploadedImage[2]
                                      ? Container(
                                          child: Image(
                                            width: 150,
                                            height: 150,
                                            image: FileImage(
                                                proofImagePickerController
                                                    .choosenImage[2]),
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Container(
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
                                                      const EdgeInsets.fromLTRB(
                                                          0, 37.5, 0, 0),
                                                  child: Icon(
                                                    Icons.add_sharp,
                                                    size: 40,
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))),
                          InkWell(
                            onTap: () {
                              proofImagePickerController.pickImage(context, 3);
                            },
                            child: Obx(() => proofImagePickerController
                                    .uploadedProofImg.value
                                ? (proofImagePickerController.networkImg[3] !=
                                        ""
                                    ? Container(
                                        child: Image(
                                          width: 150,
                                          height: 150,
                                          image: CachedNetworkImageProvider(
                                              proofImagePickerController
                                                  .networkImg[3]),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
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
                                                    const EdgeInsets.fromLTRB(
                                                        0, 37.5, 0, 0),
                                                child: Icon(
                                                  Icons.add_sharp,
                                                  size: 40,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ))
                                : proofImagePickerController.isUploadedImage[3]
                                    ? Container(
                                        child: Image(
                                          width: 150,
                                          height: 150,
                                          image: FileImage(
                                              proofImagePickerController
                                                  .choosenImage[3]),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Container(
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
                                                    const EdgeInsets.fromLTRB(
                                                        0, 37.5, 0, 0),
                                                child: Icon(
                                                  Icons.add_sharp,
                                                  size: 40,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                          ),
                        ],
                      ),
                    )),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      StartupDataBase().uploadProofImages(
                          proofImagePickerController.choosenImage,
                          "pof_image",
                          widget.stageUid,
                          widget.workStreamId);
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
