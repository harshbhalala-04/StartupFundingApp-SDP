// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Chat",
          style: TextStyle(
            fontFamily: "Cabin",
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Text("Chat"),
    );
  }
}
