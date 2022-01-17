// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class InvestorPersonalInfoScreen extends StatefulWidget {
  final User? user = FirebaseAuth.instance.currentUser;

  InvestorPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _InvestorPersonalInfoScreenState createState() =>
      _InvestorPersonalInfoScreenState();
}

class _InvestorPersonalInfoScreenState
    extends State<InvestorPersonalInfoScreen> {
  TextEditingController firstName = new TextEditingController();
  TextEditingController lastName = new TextEditingController();
  TextEditingController linkedinUrl = new TextEditingController();
  TextEditingController cityName = new TextEditingController();
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Startup Funding"),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 100,
              ),
              Container(
                  padding: EdgeInsets.only(left: 30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Help us get to know you better!",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 45,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: firstName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "First Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.person,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: lastName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Last Name",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.add_link,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: linkedinUrl,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Linkedin Url",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.deepPurpleAccent,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                margin: new EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Icon(
                        Icons.location_city,
                        color: Colors.grey,
                        size: 20,
                      ),
                    ),
                    new Expanded(
                        child: TextFormField(
                      controller: cityName,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Enter the city do you live in?",
                        hintStyle: TextStyle(color: Colors.grey),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        isDense: true,
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 200,
              ),
              Container(
                margin: new EdgeInsets.fromLTRB(40, 0, 40, 0),
                child: ElevatedButton(
                  child: Text("Continue"),
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromRGBO(117, 104, 177, 1),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                  ),
                  onPressed: () => InvestorDataBase().addInvestorPersonalInfo(
                      firstName, lastName, linkedinUrl, cityName,user),
                ),
              ),
            ],
          ),
        ));
  }
}
