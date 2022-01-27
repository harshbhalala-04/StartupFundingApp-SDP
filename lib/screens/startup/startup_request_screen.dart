// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:startupfunding/screens/startup/startup_request_recieve_screen.dart';
import 'package:startupfunding/screens/startup/startup_request_sent_screen.dart';

class StartupRequestScreen extends StatelessWidget {
  var n;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          toolbarHeight: 0,
          bottom: TabBar(
            indicatorColor: Theme.of(context).primaryColor,
            labelColor: Theme.of(context).primaryColor,
            unselectedLabelColor: Colors.black,
            tabs: [
              Tab(
                child: Text("Recieved"),
              ),
              Tab(
                child: Text("Sent"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            StartupRequestRecieveScreen(),
            StartupRequestSentScreen()
          ],
        ),
      ),
    );
  }
}
