// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:startupfunding/screens/investors/investor_request_recieve_screen.dart';
import 'package:startupfunding/screens/investors/investor_request_sent_screen.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({Key? key}) : super(key: key);

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
                child: Text("Recieved", 
                style: TextStyle(
                  color: Theme.of(context).primaryColor, 
                  fontFamily: "Cabin", 
                  fontSize: 18, 
                  ),
                ),
              ),
              Tab(
                child: Text("Sent",
                 style: TextStyle(
                   color: Theme.of(context).primaryColor, 
                   fontFamily: "Cabin", 
                   fontSize: 18, 
                   ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            InvestorRequestRecieveScreen(),
            InvestorRequestSentScreen()
          ],
        ),
      ),
    );
  }
}
