// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class InvestorPersonalInfoScreen extends StatefulWidget {
  TextEditingController firstname = new TextEditingController();
  TextEditingController lastname = new TextEditingController();
  TextEditingController linkedinurl = new TextEditingController();
  TextEditingController cityname = new TextEditingController();
   InvestorPersonalInfoScreen({Key? key}) : super(key: key);

  @override
  _InvestorPersonalInfoScreenState createState() =>
      _InvestorPersonalInfoScreenState();
}

class _InvestorPersonalInfoScreenState
    extends State<InvestorPersonalInfoScreen> {
  var firstname;

  var lastname;

  var linkedinurl;

  var cityname;

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
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "       Help us get to know you better!",
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
                      controller: firstname,
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
                      controller: lastname,
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
                      controller: linkedinurl,
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
                      controller: cityname,
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
                  onPressed: () {
                    Map<String, dynamic> data = {
                      "First Name": firstname.text,
                      "Last Name": lastname.text,
                      "Likedin URL": linkedinurl.text,
                      "City Name": cityname.text
                    };
                    Firestore.instance.collection("Investor Details").add(data);
                  },
                ),
              ),
            ],
          ),
        ));
  }
}

class Firestore {
  static var instance;
}
