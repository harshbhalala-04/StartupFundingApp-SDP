// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/widgets/custom_textformfield.dart';

class InvestorEditProfileScreen extends StatefulWidget {
  const InvestorEditProfileScreen({Key? key}) : super(key: key);

  @override
  State<InvestorEditProfileScreen> createState() =>
      _InvestorEditProfileScreenState();
}

class _InvestorEditProfileScreenState extends State<InvestorEditProfileScreen> {
  TextEditingController investorFirstNameController =
      new TextEditingController();

  TextEditingController investorLastNameController =
      new TextEditingController();

  TextEditingController investorPhoneNoController = new TextEditingController();

  TextEditingController investorEmailController = new TextEditingController();

  TextEditingController investorLinkedinUrlController =
      new TextEditingController();

  TextEditingController investorCityController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    investorFirstNameController.text =
        Get.find<InvestorGlobalController>().currentInvestor.firstName!;
    investorLastNameController.text =
        Get.find<InvestorGlobalController>().currentInvestor.lastName!;

    investorPhoneNoController.text =
        Get.find<InvestorGlobalController>().currentInvestor.phoneNo!;
    investorEmailController.text =
        Get.find<InvestorGlobalController>().currentInvestor.email!;

    investorLinkedinUrlController.text =
        Get.find<InvestorGlobalController>().currentInvestor.linkedinUrl!;
    investorCityController.text =
        Get.find<InvestorGlobalController>().currentInvestor.cityName!;
  }

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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: investorFirstNameController,
                  onEditingComplete: () {
                    InvestorDataBase().updateInvestorFirstName(
                        investorFirstNameController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "First Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: investorLastNameController,
                  onEditingComplete: () {
                    InvestorDataBase().updateInvestorLastName(
                        investorLastNameController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Last Name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: investorPhoneNoController,
                  onEditingComplete: () {
                    InvestorDataBase()
                        .updateInvestorPhoneNo(investorPhoneNoController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Phone No",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: investorEmailController,
                  onEditingComplete: () {
                    InvestorDataBase()
                        .updateInvestorEmail(investorEmailController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: investorLinkedinUrlController,
                  onEditingComplete: () {
                    InvestorDataBase().updateInvestorLinkedinUrl(
                        investorLinkedinUrlController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "Linkedin Url",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: investorCityController,
                  onEditingComplete: () {
                    InvestorDataBase()
                        .updateInvestorCityName(investorCityController.text);
                  },
                  decoration: InputDecoration(
                    labelText: "City",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 250,
                child: ElevatedButton(
                  onPressed: () {
                    InvestorDataBase().updateInvestorFirstName(investorFirstNameController.text);
                    InvestorDataBase().updateInvestorLastName(investorLastNameController.text);
                    InvestorDataBase().updateInvestorPhoneNo(investorPhoneNoController.text);
                    InvestorDataBase().updateInvestorEmail(investorEmailController.text);
                    InvestorDataBase().updateInvestorLinkedinUrl(investorLinkedinUrlController.text);
                    InvestorDataBase().updateInvestorCityName(investorCityController.text);
                    Get.back();
                  },
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
