// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/widgets/custom_textformfield.dart';

class StartupEditProfileScreen extends StatelessWidget {
  const StartupEditProfileScreen({Key? key}) : super(key: key);

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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/test_image.png"),
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
                  SizedBox(width: 70),
                  InkWell(
                    onTap: () {},
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 23, 0, 0),
                          child: CircleAvatar(
                            backgroundImage:
                                AssetImage("assets/test_image.png"),
                            radius: 50.0,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            "Edit Startup Logo",
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
                ],
              ),
            ),
            SizedBox(height: 20),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Name",
                  initialValue: "Gopal Malaviya",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Startup Name",
                  initialValue: "Gopal Malaviya",
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Startup Registered Name",
                  initialValue: "Gopal Malaviya",
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
                  labelText: "Website/App Url",
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
            InkWell(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
                child: Container(
                  height: 120,
                  child: TextFormField(
                    maxLines: 10,
                    initialValue:
                        "kaik to hash ggofd df af afaf af df sdg gs gs fsa e fe gegggggg g gsg sssssssssss e j ne",
                    decoration: InputDecoration(
                      labelText: "Discription",
                      border: OutlineInputBorder(),
                    ),
                    maxLength: 100,
                  ),
                ),
              ),
            ),


            
          ],
        ),
      ),
    );
  }
}
