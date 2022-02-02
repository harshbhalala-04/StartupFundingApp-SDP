// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
      body: Center(
        child: Text("Workstream between startup to investor"),
      ),
    );
  }
}
