// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/widgets/custom_textformfield.dart';

class InvestorEditProfileScreen extends StatelessWidget {
  const InvestorEditProfileScreen({Key? key}) : super(key: key);

  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style:
              TextStyle(color: Colors.black, fontFamily: "Cabin", fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 180,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: <Color>[
                        Color.fromRGBO(10, 102, 194, 0.9),
                        Color.fromRGBO(117, 104, 184, 1)
                      ]),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30)),
                  color: Colors.deepPurpleAccent),
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                      child: CircleAvatar(
                        backgroundImage: AssetImage("assets/test_image.png"),
                        radius: 50.0,
                        backgroundColor: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: Text(
                        "Edit Profile Photo",
                        style: TextStyle(
                          fontFamily: "Cabin",
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: " First Name",
                  initialValue: "Gopal",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Last Name",
                  initialValue: "Malaviya",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Phone No",
                  initialValue: "Gopal Malaviya",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Email",
                  initialValue: "Gopal Malaviya",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Linkedin Url",
                  initialValue: "Gopal Malaviya",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "City",
                  initialValue: "Gopal Malaviya",
                )),
          ],
        ),
      ),
    );
  }
}
