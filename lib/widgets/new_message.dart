// ignore_for_file: unnecessary_new, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/database/startup_database.dart';

class NewMessage extends StatefulWidget {
  late final myUsername;
  late final workStreamId;
  late final otherUsername;
  late final otherUserUid;
  late final userType;

  NewMessage(
      {required this.myUsername,
      required this.workStreamId,
      required this.otherUsername,
      required this.otherUserUid,
      required this.userType});
  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _controller = TextEditingController();
  var _enterdMessage = '';
  String messageId = '';

  String getMessageId() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 12; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  addMessage() {
    String message = _enterdMessage;
    var lastMessageTs = DateTime.now();
    print("this is my username: ${widget.myUsername}");

    if (widget.userType == "Investor") {
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": Get.find<InvestorGlobalController>().currentInvestor.uid,
        "ts": lastMessageTs,
        "otherUserUid": widget.otherUserUid
      };

      //message ID
      if (messageId == '') {
        messageId = getMessageId();
      }

      _controller.clear();
      print("New message chatRoomId: ${widget.workStreamId}");
      print("Other user id: ${widget.otherUserUid}");

      InvestorDataBase()
          .addMessageMethod(
        widget.workStreamId,
        messageId,
        messageInfoMap,
      )
          .then((val) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageTs": lastMessageTs,
        };

        InvestorDataBase()
            .updateLastMessageSend(widget.workStreamId, lastMessageInfoMap);
        messageId = '';
      });
    } else if (widget.userType == "Startup") {
      Map<String, dynamic> messageInfoMap = {
        "message": message,
        "sendBy": Get.find<StartupGlobalController>().currentStartup.uid,
        "ts": lastMessageTs,
        "otherUserUid": widget.otherUserUid
      };

      //message ID
      if (messageId == '') {
        messageId = getMessageId();
      }

      _controller.clear();
     

      StartupDataBase()
          .addMessageMethod(
        widget.workStreamId,
        messageId,
        messageInfoMap,
      )
          .then((val) {
        Map<String, dynamic> lastMessageInfoMap = {
          "lastMessage": message,
          "lastMessageTs": lastMessageTs,
        };

        StartupDataBase()
            .updateLastMessageSend(widget.workStreamId, lastMessageInfoMap);
        messageId = '';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 60,
                  ),
                  child: Scrollbar(
                    child: TextField(
                      controller: _controller,
                      textCapitalization: TextCapitalization.sentences,
                      autocorrect: true,
                      maxLines: null,
                      enableSuggestions: true,
                      decoration:
                          InputDecoration(hintText: 'Send a message...'),
                      onChanged: (value) {
                        setState(() {
                          _enterdMessage = value;
                        });
                      },
                    ),
                  ),
                ),
              ),
              IconButton(
                color: Theme.of(context).primaryColor,
                icon: Icon(
                  Icons.send,
                ),
                onPressed: _enterdMessage.trim().isEmpty
                    ? null
                    : () {
                        addMessage();
                      },
              ),
            ],
          ),
        )
        //margin: EdgeInsets.only(top: 8),

        );
  }
}
