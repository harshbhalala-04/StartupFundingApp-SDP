// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/widgets/work_stream_tile.dart';

class StartupChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Workstream",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Cabin",
              fontWeight: FontWeight.bold,
              fontSize: 20),
        ),
      ),
      body: SingleChildScrollView(
          child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("workstream")
            .orderBy("lastMessageTs", descending: true)
            .where("userIds",
                arrayContains:
                    Get.find<StartupGlobalController>().currentStartup.uid)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data.docs.length == 0) {
            return Container(
              margin: EdgeInsets.only(top: 300),
              child: Center(
                child: Text(
                  'Your workstreams appear Here.',
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
                          Get.find<StartupGlobalController>().currentStartup.uid
                      ? ds['secondUserName']
                      : ds['firstUserName'],
                  otherUserImg: ds['firstUserUid'] ==
                          Get.find<StartupGlobalController>().currentStartup.uid
                      ? ds['secondUserImg']
                      : ds['firstUserImg'],
                  otherUserUid: ds['firstUserUid'] ==
                          Get.find<StartupGlobalController>().currentStartup.uid
                      ? ds['secondUserUid']
                      : ds['firstUserUid'],
                  userType: "Startup",
                );
              });
        },
      )),
    );
  }
}
