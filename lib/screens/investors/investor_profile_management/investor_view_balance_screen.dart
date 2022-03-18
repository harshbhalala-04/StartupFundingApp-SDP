// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_view_balance_controller.dart';

class InvestorViewBalanceScreen extends StatelessWidget {
  final InvestorViewBalanceController investorViewBalanceController =
      Get.put(InvestorViewBalanceController());

  @override
  Widget build(BuildContext context) {
    investorViewBalanceController.sendEther();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Balance",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Text(
          "100 ethers",
          style: TextStyle(fontFamily: "Cabin", fontSize: 24),
        ),
      ),
    );
  }
}
