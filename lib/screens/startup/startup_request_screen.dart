// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class StartupRequestScreen extends StatelessWidget {
  var n;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(30,0,0,0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Pending ($n)",
                    style: TextStyle(
                        fontSize: 20, color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
