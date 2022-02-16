// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
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
                        backgroundImage: NetworkImage(
                            Get.find<InvestorGlobalController>()
                                .currentInvestor
                                .investorImg!),
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
                  labelText: "First Name",
                  initialValue: Get.find<InvestorGlobalController>()
                      .currentInvestor
                      .firstName
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Last Name",
                  initialValue: Get.find<InvestorGlobalController>()
                      .currentInvestor
                      .lastName
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Phone No",
                  initialValue: Get.find<InvestorGlobalController>()
                      .currentInvestor
                      .phoneNo
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Email",
                  initialValue: Get.find<InvestorGlobalController>()
                      .currentInvestor
                      .email
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "Linkedin Url",
                  initialValue: Get.find<InvestorGlobalController>()
                      .currentInvestor
                      .linkedinUrl
                      .toString(),
                )),
            InkWell(
                onTap: () {},
                child: CustomTextFormField(
                  labelText: "City",
                  initialValue: Get.find<InvestorGlobalController>()
                      .currentInvestor
                      .cityName
                      .toString(),
                )),
                
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      primary: Theme.of(context).primaryColor),
                  child: Text(
                    "Update Profile",
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
}
