// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class PendingStatusScreen extends StatelessWidget {
  const PendingStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Text(
          "Your profile is under review wait for some time to do verification by admin",
          style: TextStyle(
            fontFamily: "Cabin",
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
