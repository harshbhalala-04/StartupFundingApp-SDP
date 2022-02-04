// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/widgets/new_message.dart';
import 'package:intl/intl.dart';

class InvestorWorkStreamRoom extends StatefulWidget {
  final String otherUsername;
  final String otherImgUrl;
  final String workStreamId;
  final String otherUid;

  InvestorWorkStreamRoom(
      {required this.otherImgUrl,
      required this.otherUsername,
      required this.otherUid,
      required this.workStreamId});

  @override
  _InvestorWorkStreamRoomState createState() => _InvestorWorkStreamRoomState();
}

class _InvestorWorkStreamRoomState extends State<InvestorWorkStreamRoom> {
  dynamic messageStream;
  getAndSetMessages() async {
    messageStream =
        await InvestorDataBase().getWorkStreamMessages(widget.workStreamId);
    setState(() {});
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
              padding: const EdgeInsets.all(15.0),
              child: Icon(
                Icons.more_vert,
                color: Colors.white,
              ))
        ],
        flexibleSpace: Container(
          margin: EdgeInsets.only(top: 28),
          child: Row(
            children: [
              InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      size: 22,
                      color: Colors.white,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                  }),
              SizedBox(width: 10),
              CircleAvatar(
                backgroundColor: Color.fromRGBO(196, 196, 196, 1),
                backgroundImage: CachedNetworkImageProvider(widget.otherImgUrl),
                radius: 20,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.otherUsername,
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: bodyWidget(),
    );
  }

  /// Body of the workstream room.
  Widget bodyWidget() {
    return Column(
      children: [
        chatMessages(),
        NewMessage(
          workStreamId: widget.workStreamId,
          myUsername: Get.find<InvestorGlobalController>()
                  .currentInvestor
                  .firstName! +
              " " +
              Get.find<InvestorGlobalController>().currentInvestor.lastName!,
          otherUsername: widget.otherUsername,
          otherUserUid: widget.otherUid,
          userType: "Investor",
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
                  image: AssetImage("assets/chat_bg.jpg"),
                  fit: BoxFit.fill,
                ),
              ),
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
                            Get.find<InvestorGlobalController>()
                                .currentInvestor
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
