// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class StageProofCard extends StatelessWidget {
  final IconData iconData;
  final String title;
  StageProofCard({required this.iconData, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 80,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: ListTile(
              leading: Icon(iconData),
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                ),
              ),
              trailing: TextButton(
                  child: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () {}),
            ),
          ),
        ),
      ),
    );
  }
}
