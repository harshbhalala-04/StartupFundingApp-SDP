// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class RejectedStatusScreen extends StatelessWidget {
  const RejectedStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Your profile is rejected by admin",
        style: TextStyle(
          fontFamily: "Cabin",
          fontSize: 20,
        ),
      ),
    );
  }
}
