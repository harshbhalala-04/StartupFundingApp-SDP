// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/stage_startup_screen.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

import '../../../database/startup_database.dart';
import '../../../widgets/alert_dialogue.dart';
import '../../../widgets/bottom_navigation_button.dart';

class EquityDetailScreen extends StatefulWidget {
  const EquityDetailScreen({Key? key}) : super(key: key);

  @override
  State<EquityDetailScreen> createState() => _EquityDetailScreenState();
}

class _EquityDetailScreenState extends State<EquityDetailScreen> {
  TextEditingController amountController = new TextEditingController();
  TextEditingController equityController = new TextEditingController();
  TextEditingController valuationController = new TextEditingController();

  checkData() {
    if (amountController.text == "") {
      createAlertDialogue("Please enter amount you want to raise.");
    } else if (equityController.text == "") {
      createAlertDialogue("Please enter equity stack you want to dilute.");
    }  else if (valuationController.text == "") {
      createAlertDialogue("Please enter your company's valuation.");
    } else {
      Get.to(StartupStageScreen());
      StartupDataBase().addEquityDetails(amountController.text, equityController.text, valuationController.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: OnBoardingAppBarTitle(),
        leading: InkWell(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_ios_new_outlined,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                'How much amount do you want to raise?',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    amountController.text = val;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter amount in ether",
                    suffixText: "Ether",
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'How much Equity do you want to dilute?',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    equityController.text = val;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter equity stack",
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
              Text(
                'Enter your company valuation',
                style: TextStyle(
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onChanged: (val) {
                    valuationController.text = val;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter amount in ether",
                    suffixText: "Ether",
                    border: OutlineInputBorder(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      borderSide: BorderSide(width: 2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationButton(
        checkData: checkData,
      ),
    );
  }
}
