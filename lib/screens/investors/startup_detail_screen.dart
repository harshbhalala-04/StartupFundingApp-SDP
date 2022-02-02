// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_request_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/models/startup_model.dart';
import 'package:startupfunding/widgets/confirm_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:open_file/open_file.dart';

class StartupDetailScreen extends StatefulWidget {
  StartupModel? startup;
  String? uid;
  final bool fromReq;
  var viewProfile;
  StartupDetailScreen(
      {this.startup, this.uid, required this.fromReq, required this.viewProfile});

  @override
  State<StartupDetailScreen> createState() => _StartupDetailScreenState();
}

class _StartupDetailScreenState extends State<StartupDetailScreen> {
  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  ///Download file into private folder
  Future<File?> downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$fileName");

    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print("path: ${file.path}");
    OpenFile.open(file.path);
  }

  bool isLoading = false;

  fetchStartupDetails(String uid) async {
    setState(() {
      isLoading = true;
    });

    await FirebaseFirestore.instance
        .collection("Startups")
        .doc(uid)
        .get()
        .then((val) {
      widget.startup = StartupModel.fromJson(val.data()!);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.fromReq) {
      fetchStartupDetails(widget.uid!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Startup Profile",
          style:
              TextStyle(color: Colors.black, fontFamily: "Cabin", fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(
                    image: CachedNetworkImageProvider(
                        widget.startup!.startupLogoUrl!),
                    width: MediaQuery.of(context).size.width,
                    height: 300,
                  ),
                  Center(
                    child: Text(
                      widget.startup!.startupName!,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_on_sharp,
                          color: Colors.black,
                          size: 20,
                        ),
                        Text(
                          widget.startup!.startupCity!,
                          style: TextStyle(
                            fontFamily: "Cabin",
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  widget.viewProfile
                      ? Container()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                if (widget.fromReq) {
                                  final InvestorRequestController
                                      investorRequestController =
                                      Get.put(InvestorRequestController());
                                  // 1. Remove from pending list
                                  investorRequestController
                                      .removeRecievedStartup(
                                          widget.startup!.uid!);

                                  // 2. Back to pending page
                                  Get.back();

                                  // 3. Remove from database
                                  InvestorDataBase().removeStartupFromPending(
                                      widget.startup!.uid!);
                                } else {
                                  // 1. Remove Startup from feed
                                  Get.find<InvestorGlobalController>()
                                      .removeStartupFromFeed(
                                          widget.startup!.uid!);

                                  // 2. Go back to prev route
                                  Get.back();

                                  // 3. Add startup to exclude list
                                  InvestorDataBase().addStartupToExcludeList(
                                      widget.startup!.uid!, false);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Text(
                                  widget.fromReq ? "Reject" : "Skip",
                                  style: TextStyle(
                                      color: Colors.grey,
                                      fontFamily: "Cabin",
                                      fontSize: 18),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  primary: Colors.white),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                if (widget.fromReq) {
                                  final InvestorRequestController
                                      investorRequestController =
                                      Get.put(InvestorRequestController());
                                  // 1. Remove from pending list
                                  investorRequestController
                                      .removeRecievedStartup(
                                          widget.startup!.uid!);

                                  // 2. Back to pending page
                                  Get.back();

                                  // 3. Remove from database
                                  InvestorDataBase().removeStartupFromPending(
                                      widget.startup!.uid!);

                                  // 4. Add User to MatchUsers
                                  InvestorDataBase().acceptOffer(
                                      Get.find<InvestorGlobalController>()
                                              .currentInvestor
                                              .firstName! +
                                          " " +
                                          Get.find<InvestorGlobalController>()
                                              .currentInvestor
                                              .lastName!,
                                      Get.find<InvestorGlobalController>()
                                          .currentInvestor
                                          .investorImg!,
                                      widget.startup!.startupName!,
                                      widget.startup!.startupLogoUrl!,
                                      widget.startup!.uid!);
                                } else {
                                  // 1. Remove Startup from feed
                                  Get.find<InvestorGlobalController>()
                                      .removeStartupFromFeed(
                                          widget.startup!.uid!);

                                  // 2. Go back to prev route
                                  Get.back();

                                  Timestamp time = Timestamp.now();
                                  Get.find<InvestorRequestController>()
                                      .inviteSentList
                                      .add({
                                    "sent": widget.startup!.startupName,
                                    "id": widget.startup!.uid,
                                    "image": widget.startup!.startupLogoUrl,
                                    "time": time,
                                  });
                                  Get.find<InvestorRequestController>()
                                      .inviteSentList
                                      .sort((a, b) =>
                                          b["time"].compareTo(a["time"]));

                                  // 3. Add startup to exclude list
                                  InvestorDataBase().addStartupToExcludeList(
                                      widget.startup!.uid!, true);

                                  // 4. Add Startup to invite list
                                  InvestorDataBase().addStartupToInviteList(
                                      widget.startup!.uid!,
                                      widget.startup!.startupLogoUrl!,
                                      widget.startup!.startupName!,
                                      Get.find<InvestorGlobalController>()
                                          .currentInvestor
                                          .uid!,
                                      Get.find<InvestorGlobalController>()
                                          .currentInvestor
                                          .investorImg!,
                                      Get.find<InvestorGlobalController>()
                                              .currentInvestor
                                              .firstName! +
                                          " " +
                                          Get.find<InvestorGlobalController>()
                                              .currentInvestor
                                              .lastName!);
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 10),
                                child: Text(
                                  widget.fromReq ? "Accept" : "Invite",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Cabin",
                                      fontSize: 18),
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  primary: Theme.of(context).primaryColor),
                            ),
                          ],
                        ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Category",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 70,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.startup!.startupCategory!,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: widget.startup!.coFounderImg == "" ||
                            widget.startup!.coFounderImg == null
                        ? MainAxisAlignment.center
                        : MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: CachedNetworkImageProvider(
                              widget.startup!.founderImg!,
                            ),
                            radius: 50,
                          ),
                          Text(
                            widget.startup!.userName!,
                            style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Founder",
                            style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                                color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(widget.startup!.linkedinUrl!);
                            },
                            child: Image(
                              image: AssetImage("assets/linkedin-color.png"),
                            ),
                          ),
                        ],
                      ),
                      widget.startup!.coFounderImg == "" ||
                              widget.startup!.coFounderImg == null
                          ? Container()
                          : Column(
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.grey,
                                  backgroundImage: CachedNetworkImageProvider(
                                      widget.startup!.coFounderImg!),
                                  radius: 50,
                                ),
                                Text(
                                  widget.startup!.secondFounderName!,
                                  style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Co-Founder",
                                  style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 20,
                                      color: Colors.grey),
                                ),
                                InkWell(
                                  onTap: () {
                                    _launchURL(widget
                                        .startup!.secondFounderLinkedinUrl!);
                                  },
                                  child: Image(
                                    image:
                                        AssetImage("assets/linkedin-color.png"),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "About ${widget.startup!.startupName}",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      widget.startup!.startupDescription!,
                      style: TextStyle(fontFamily: "Cabin", fontSize: 18),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Startup Stage",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width - 50,
                      height: 70,
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            widget.startup!.startupStage!,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "Pitch Deck",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.snackbar(
                        "Wait",
                        "File Downloading",
                        snackPosition: SnackPosition.BOTTOM,
                        colorText: Theme.of(context).primaryColor,
                      );
                      openFile(url: widget.startup!.pitchDeckUrl!);
                    },
                    child: ListTile(
                      leading: Icon(
                        Icons.picture_as_pdf,
                        color: Theme.of(context).primaryColor,
                        size: 30,
                      ),
                      title: Text(
                        "${widget.startup!.startupName} Pitch Deck",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin",
                          fontSize: 20,
                        ),
                      ),
                      trailing: Icon(
                        Icons.download,
                        size: 30,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
    );
  }
}
