// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_payment_controller.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

class PaymentConfirmScreen extends StatelessWidget {
  const PaymentConfirmScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: OnBoardingAppBarTitle(),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(
                    child: Image(
                      image: AssetImage("assets/payment_done.png"),
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Transaction Hash",
              style: TextStyle(
                fontFamily: "Cabin",
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 10),
            Text(
              Get.find<InvestorPaymentController>().transactionHash.value,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "Cabin",
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
