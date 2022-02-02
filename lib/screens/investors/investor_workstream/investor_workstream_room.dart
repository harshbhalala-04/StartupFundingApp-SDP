// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: Expanded(
      //       child: Row(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: [
      //           IconButton(
      //             onPressed: () {
      //               Get.back();
      //             },
      //             icon: Icon(Icons.arrow_back),
      //             color: Colors.white,
      //           ),
      //           CircleAvatar(
      //             radius: 20,
      //             backgroundColor: Colors.grey,
      //             backgroundImage:
      //                 CachedNetworkImageProvider(widget.otherImgUrl),
      //           ),
      //           Text(
      //             widget.otherUsername,
      //             style: TextStyle(
      //                 color: Colors.white, fontFamily: "Cabin", fontSize: 20),
      //           ),
      //         ],
      //       ),
      //     ),
      //   ),
      //   backgroundColor: Theme.of(context).primaryColor,
      // ),
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
      body: Center(
        child: Text("Workstream between investor to startup"),
      ),
    );
  }
}
