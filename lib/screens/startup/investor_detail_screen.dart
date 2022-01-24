// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvestorDetailScreen extends StatefulWidget {
  const InvestorDetailScreen({Key? key}) : super(key: key);

  @override
  _InvestorDetailScreenState createState() => _InvestorDetailScreenState();
}

class _InvestorDetailScreenState extends State<InvestorDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Investor Profile",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Cabin",
              fontSize: 20),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: CircleAvatar(
                  radius: 75.0,
                  child: ClipRRect(
                    child: Image.asset('assets/test_image.png'),
                    borderRadius: BorderRadius.circular(75.0),
                  ),
                ),
              ),
              Center(
                child: Text(
                  "Abc Def",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Cabin",
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text("CEO of XYZ",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    )),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text("City",
                    style: TextStyle(
                      color: Colors.grey,
                      fontFamily: "Cabin",
                      fontSize: 18,
                    )),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(
                    child: Divider(
                      indent: 30.0,
                      endIndent: 10.0,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                  Image(
                    image: AssetImage("assets/linkedin-color.png"),
                  ),
                  Expanded(
                    child: Divider(
                      indent: 10.0,
                      endIndent: 30.0,
                      thickness: 1,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Skip",
                        style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Cabin",
                            fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        primary: Colors.white),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Text(
                        "Invite",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Cabin",
                            fontSize: 18),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(40),
                          ),
                        ),
                        primary: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "About ABC",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Lorem ipsum dolor sit amet,  consectetur adipiscing elit. Suspendisse placerat pretium ex. Suspendisse vel aliquam tortor. Etiam congue sit amet orci id efficitur. Aliquam at dignissim leo, et bibendum lorem. Morbi dui dui, sollicitudin id enim vitae, dignissim commodo nulla. Aenean tellus purus, accumsan ut ex nec, ornareec.",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Category Abc invests in",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: SizedBox(
                              width: 85,
                              child: ElevatedButton(
                                child: Text("C 1"),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: SizedBox(
                              width: 85,
                              child: ElevatedButton(
                                child: Text("C 2"),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: SizedBox(
                              width: 85,
                              child: ElevatedButton(
                                child: Text("C 3"),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25)),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                            child: SizedBox(
                              width: 85,
                              child: ElevatedButton(
                                child: Text("C 4"),
                                style: TextButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                onPressed: () {},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Profession",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Best Describe you",
                            style: TextStyle(fontSize: 18),
                          ),
                          width: 300,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Angel Invested Before",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Yes",
                            style: TextStyle(fontSize: 18),
                          ),
                          width: 300,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Investment Preference",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Co-invest with a group",
                            style: TextStyle(fontSize: 18),
                          ),
                          width: 300,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Startup Mentorship",
                        style: TextStyle(
                            fontSize: 20,
                            color: Theme.of(context).primaryColor),
                      ),
                    ),
                    SizedBox(height: 25),
                    Container(
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(20), // if you need this
                          side: BorderSide(
                            color: Colors.grey.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Yes",
                            style: TextStyle(fontSize: 18),
                          ),
                          width: 300,
                          height: 60,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
