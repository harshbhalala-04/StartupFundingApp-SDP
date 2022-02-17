// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:startupfunding/database/startup_database.dart';

class CustomTextFormField extends StatelessWidget {
  final String initialValue;
  final String labelText;
  CustomTextFormField({required this.initialValue, required this.labelText});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
      child: Container(
        height: 80,
        child: TextFormField(
          // controller: nameController,
          onEditingComplete: (){
            // StartupDataBase().updateStartupUserName(nameContoller.text=get.contoller valu...);
          },
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }
}
