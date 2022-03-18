// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_if_null_operators

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/create_edit_stage_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/screens/startup/startup_workstream/create_edit_stage_screen.dart';
import 'package:startupfunding/screens/startup/startup_workstream/stage_proof_screen.dart';
import 'package:startupfunding/screens/startup/startup_workstream/startup_request_stage_screen.dart';
import 'package:startupfunding/screens/startup/startup_workstream/view_funding_screen.dart';
import 'package:startupfunding/screens/startup/startup_workstream/view_status_screen.dart';
import 'package:startupfunding/screens/startup/startup_workstream/work_proof.dart';
import 'package:startupfunding/widgets/new_message.dart';
import 'package:intl/intl.dart';

class StartupWorkStreamRoom extends StatefulWidget {
  final String otherUsername;
  final String otherImgUrl;
  final String workStreamId;
  final String otherUid;

  StartupWorkStreamRoom(
      {required this.otherImgUrl,
      required this.otherUsername,
      required this.otherUid,
      required this.workStreamId});

  @override
  State<StartupWorkStreamRoom> createState() => _StartupWorkStreamRoomState();
}

class _StartupWorkStreamRoomState extends State<StartupWorkStreamRoom> {
  dynamic messageStream;
  bool stageCreated = false;
  bool isLoading = false;

  final CreateEditStageController createEditStageController =
      Get.put(CreateEditStageController());
  getAndSetMessages() async {
    print("Here init state is occured");
    setState(() {
      isLoading = true;
    });
    messageStream =
        await StartupDataBase().getWorkStreamMessages(widget.workStreamId);
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(widget.workStreamId)
        .get()
        .then((val) {
      stageCreated = val.data()!['stageCreated'] ?? false;
      createEditStageController.isStageSubmitted.value =
          val.data()!['submitStage'] == null
              ? false
              : val.data()!['submitStage'];
    });

    if (stageCreated) {
      print(stageCreated);
      print("Here stage fetches occures");
      createEditStageController.fetchStages(widget.workStreamId);
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState

    getAndSetMessages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: Container(
              alignment: Alignment.center,
              child: IconButton(
                icon: Icon(Icons.more_vert),
                color: Colors.white,
                onPressed: () {
                  showModalBottomSheet(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    )),
                    context: context,
                    builder: (ctx) {
                      return Container(
                        height: 350,
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  child: Text(
                                    "View Current Status",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(ViewStatusScreen(
                                      workStreamId: widget.workStreamId,
                                    ));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 5,
                                  endIndent: 5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  child: Text(
                                    "Create/Edit Stage",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => CreateEditStageScreen(
                                        workStreamId: widget.workStreamId));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 5,
                                  endIndent: 5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  child: Text(
                                    "Request stage",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(StartupRequestStageScreen(
                                        workStreamId: widget.workStreamId));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 5,
                                  endIndent: 5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  child: Text(
                                    "View Funding",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(ViewFundingScreen(
                                        workStreamId: widget.workStreamId));
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Divider(
                                  color: Colors.grey,
                                  height: 5,
                                  endIndent: 5,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: TextButton(
                                  child: Text(
                                    "Submit stage",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 18,
                                    ),
                                  ),
                                  onPressed: () {
                                    Get.to(() => StageProofScreen(
                                        workStreamId: widget.workStreamId));
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 28),
          child: Row(
            children: [
              InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 22,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              SizedBox(width: 10),
              Container(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundColor: Color.fromRGBO(196, 196, 196, 1),
                  backgroundImage:
                      CachedNetworkImageProvider(widget.otherImgUrl),
                  radius: 20,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  widget.otherUsername,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : bodyWidget(),
    );
  }

  /// Body of the workstream room.
  Widget bodyWidget() {
    return Column(
      children: [
        chatMessages(),
        NewMessage(
          workStreamId: widget.workStreamId,
          myUsername:
              Get.find<StartupGlobalController>().currentStartup.startupName!,
          otherUsername: widget.otherUsername,
          otherUserUid: widget.otherUid,
          userType: "Startup",
        ),
      ],
    );
  }

  ///List of chat messsages till time.
  Widget chatMessages() {
    return StreamBuilder(
        stream: messageStream,
        builder: (context, AsyncSnapshot<QuerySnapshot?> snapshot) {
          if (!snapshot.hasData) {
            return Container(
              height: 0,
            );
          }
          final chatDocs = snapshot.data!.docs;
          return Expanded(
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/startup_chatscreen_bg.jpg"),
                      fit: BoxFit.fill)),
              child: ListView.builder(

                  //padding: EdgeInsets.only(bottom: 40, top: 16),
                  reverse: true,
                  itemCount: chatDocs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    String? time =
                        DateFormat('hh:mm a').format(ds["ts"].toDate());

                    return chatMessageTile(
                        ds["message"],
                        ds["sendBy"] ==
                            Get.find<StartupGlobalController>()
                                .currentStartup
                                .uid,
                        time,
                        (ds["sendBy"] == "" && ds["otherUserUid"] == ""));
                  }),
            ),
          );
        });
  }

  Widget chatMessageTile(
      String message, bool sendByMe, String time, bool info) {
    return Column(
      children: [
        info
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(message,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontFamily: "Cabin",
                                fontSize: 18)),
                      )),
                ],
              )
            : Row(
                mainAxisAlignment:
                    sendByMe ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: [
                    Container(
                      decoration: BoxDecoration(
                        color: sendByMe
                            ? Colors.grey[300]
                            : Theme.of(context).primaryColor.withOpacity(0.8),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                          bottomLeft: !sendByMe
                              ? Radius.circular(0)
                              : Radius.circular(12),
                          bottomRight: sendByMe
                              ? Radius.circular(0)
                              : Radius.circular(12),
                        ),
                      ),
                      width: 160,
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 16,
                      ),
                      margin: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: sendByMe
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message,
                            style: TextStyle(
                              color: sendByMe ? Colors.black : Colors.white,
                              fontSize: 15,
                            ),
                            textAlign:
                                sendByMe ? TextAlign.end : TextAlign.start,
                          ),
                          Text(
                            time,
                            style: TextStyle(
                              color: sendByMe
                                  ? Colors.black
                                  : Theme.of(context)
                                      .accentTextTheme
                                      .headline1
                                      ?.color,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ]),
      ],
    );
  }
}
