// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/widgets/work_stream_tile.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("Inside chat");
    print(Get.find<InvestorGlobalController>().currentInvestor.uid);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Workstream",
          style: TextStyle(
            fontFamily: "Cabin",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).primaryColor,
          ),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("workstream")
            .orderBy("lastMessageTs", descending: true)
            .where("userIds",
                arrayContains:
                    Get.find<InvestorGlobalController>().currentInvestor.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          print(snapshot.data.docs.length);
          if (snapshot.data.docs.length == 0) {
            return Container(
              margin: EdgeInsets.only(top: 300),
              child: Center(
                child: Text(
                  'Your workstreams appear Here.???',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            );
          }
          final workstreams = snapshot.data!.docs;
          return ListView.builder(
              itemCount: workstreams.length,
              shrinkWrap: true,
              itemBuilder: (ctx, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return WorkStreamTile(
                  workStreamId: ds['workStreamId'],
                  lastMessage: ds['lastMessage'],
                  lastMessageTs: ds['lastMessageTs'],
                  otherUserName: ds['firstUserUid'] ==
                          Get.find<InvestorGlobalController>()
                              .currentInvestor
                              .uid
                      ? ds['secondUserName']
                      : ds['firstUserName'],
                  otherUserImg: ds['firstUserUid'] ==
                          Get.find<InvestorGlobalController>()
                              .currentInvestor
                              .uid
                      ? ds['secondUserImg']
                      : ds['firstUserImg'],
                  otherUserUid: ds['firstUserUid'] ==
                          Get.find<InvestorGlobalController>()
                              .currentInvestor
                              .uid
                      ? ds['secondUserUid']
                      : ds['firstUserUid'],
                  userType: "Investor",
                );
              });
        },
      )),
    );
  }
}
