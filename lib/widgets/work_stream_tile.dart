// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:startupfunding/screens/investors/investor_workstream/investor_workstream_room.dart';
import 'package:startupfunding/screens/startup/startup_workstream/startup_workstream_room.dart';

class WorkStreamTile extends StatefulWidget {
  final String workStreamId;
  final String lastMessage;
  late final lastMessageTs;
  final String otherUserName;
  final String otherUserImg;
  final String otherUserUid;
  final String userType;

  WorkStreamTile({
    required this.workStreamId,
    required this.lastMessage,
    required this.lastMessageTs,
    required this.otherUserName,
    required this.otherUserImg,
    required this.otherUserUid,
    required this.userType,
  });

  @override
  _WorkStreamTileState createState() => _WorkStreamTileState();
}

class _WorkStreamTileState extends State<WorkStreamTile> {
  String lastMsg = '';
  int count = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.lastMessage.length > 25) {
      lastMsg = widget.lastMessage.substring(0, 25);
      lastMsg += '...';
      count = 1;
    }
    String? time = DateFormat('hh:mm a').format(widget.lastMessageTs.toDate());

    return InkWell(
      onTap: () {
        if (widget.userType == "Investor") {
          Get.to(InvestorWorkStreamRoom(
            otherImgUrl: widget.otherUserImg,
            otherUsername: widget.otherUserName,
            workStreamId: widget.workStreamId,
            otherUid: widget.otherUserUid,
          ));
        } else {
          Get.to(StartupWorkStreamRoom(
            otherImgUrl: widget.otherUserImg,
            otherUsername: widget.otherUserName,
            workStreamId: widget.workStreamId,
            otherUid: widget.otherUserUid,
          ));
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      height: 55,
                      width: 55,
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        backgroundImage: CachedNetworkImageProvider(
                          widget.otherUserImg,
                        ),
                        radius: 25,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.otherUserName,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          count == 0 ? widget.lastMessage : lastMsg,
                          maxLines: 1,
                          softWrap: true,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            color: Color.fromRGBO(51, 51, 51, 1),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Text(time),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 60, right: 10),
            ),
          ],
        ),
      ),
    );
  }
}
