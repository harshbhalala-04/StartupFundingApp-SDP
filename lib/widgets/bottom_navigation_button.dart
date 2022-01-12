// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class BottomNavigationButton extends StatelessWidget {
  final Function checkData;

  BottomNavigationButton({required this.checkData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        height: 40,
        width: 230,
        child: ElevatedButton(
          child: Text(
            'Continue',
            style: TextStyle(fontFamily: "Cabin", fontSize: 18),
          ),
          onPressed: () {
            checkData();
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
          ),
        ),
      ),
    );
  }
}
