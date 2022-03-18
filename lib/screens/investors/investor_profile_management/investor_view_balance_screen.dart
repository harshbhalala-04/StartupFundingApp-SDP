// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_view_balance_controller.dart';
import 'package:startupfunding/database/investor_database.dart';

class InvestorViewBalanceScreen extends StatelessWidget {
  final InvestorViewBalanceController investorViewBalanceController =
      Get.put(InvestorViewBalanceController());
  TextEditingController addressController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
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
      body: Obx(
        () => investorViewBalanceController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Obx(
                () => investorViewBalanceController.isAccAddressAvailable.value
                    ? SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color.fromRGBO(60, 32, 189, 0.91),
                                    Color.fromRGBO(60, 38, 223, 0.71)
                                  ],
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                              ),
                              child: LayoutBuilder(
                                builder: (context, constraints) {
                                  return Stack(
                                    children: [
                                      Positioned(
                                        top: constraints.maxHeight * 0.1,
                                        left: constraints.maxWidth * 0.05,
                                        child: Text(
                                          "Welcome back, " +
                                              Get.find<
                                                      InvestorGlobalController>()
                                                  .currentInvestor
                                                  .firstName! +
                                              "!",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Cabin",
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: constraints.maxHeight * 0.15,
                                        left: constraints.maxWidth * 0.05,
                                        child: Text(
                                          "Smart Wallet",
                                          style: TextStyle(
                                              fontFamily: "Cabin",
                                              fontSize: 28,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white),
                                        ),
                                      ),
                                      Positioned(
                                        top: constraints.maxHeight * 0.3,
                                        left: constraints.maxWidth * 0.00,
                                        child: Container(
                                          height: constraints.maxHeight * 0.15,
                                          width: constraints.maxWidth * 0.35,
                                          decoration: BoxDecoration(
                                              gradient: RadialGradient(
                                                colors: [
                                                  Color.fromRGBO(
                                                      52, 64, 245, 1),
                                                  Color.fromRGBO(
                                                      44, 130, 177, 1)
                                                ],
                                                radius: 0.7,
                                              ),
                                              //color: Colors.red,
                                              shape: BoxShape.circle),
                                        ),
                                      ),
                                      Positioned(
                                          top: constraints.maxHeight * 0.55,
                                          right: constraints.maxWidth * 0.00,
                                          child: Container(
                                            height:
                                                constraints.maxHeight * 0.15,
                                            width: constraints.maxWidth * 0.35,
                                            decoration: BoxDecoration(
                                                gradient: RadialGradient(
                                                  colors: [
                                                    Colors.red,
                                                    Colors.pink.withOpacity(0.5)
                                                  ],
                                                  radius: 0.7,
                                                ),
                                                // color: Colors.red,
                                                shape: BoxShape.circle),
                                          )),
                                      Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: BackdropFilter(
                                            filter: ImageFilter.blur(
                                                sigmaX: 6, sigmaY: 6),
                                            child: Container(
                                              height:
                                                  constraints.maxHeight * 0.3,
                                              width:
                                                  constraints.maxWidth * 0.85,
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.white
                                                            .withOpacity(0.2),
                                                        Colors.white
                                                            .withOpacity(0.05)
                                                      ],
                                                      begin: Alignment.topLeft,
                                                      end: Alignment
                                                          .bottomRight),
                                                  border: Border.all(
                                                      color: Colors.white
                                                          .withOpacity(0.08)),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10)),
                                              child: Stack(
                                                children: [
                                                  Positioned(
                                                    top: constraints.maxHeight *
                                                        0.2 *
                                                        0.30,
                                                    left: 30,
                                                    child: Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          0.2 *
                                                          0.30,
                                                      width:
                                                          constraints.maxWidth *
                                                              0.85 *
                                                              0.7,
                                                      //color: Colors.red,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          Get.find<InvestorGlobalController>()
                                                                  .currentInvestor
                                                                  .firstName! +
                                                              " " +
                                                              Get.find<
                                                                      InvestorGlobalController>()
                                                                  .currentInvestor
                                                                  .lastName!,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.5,
                                                              fontSize: 32,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Positioned(
                                                    top: constraints.maxHeight *
                                                        0.3 *
                                                        0.45,
                                                    left: 30,
                                                    child: Container(
                                                      height: constraints
                                                              .maxHeight *
                                                          0.3 *
                                                          0.13,
                                                      width:
                                                          constraints.maxWidth *
                                                              0.85 *
                                                              0.7,
                                                      //color: Colors.red,
                                                      child: FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          investorViewBalanceController
                                                                  .accountBalance
                                                                  .value +
                                                              " ether",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              letterSpacing:
                                                                  0.5,
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .normal),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    : Center(
                        child: Container(
                          margin: EdgeInsets.all(16),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Enter Your Private Key to get started",
                                    style: TextStyle(
                                      fontFamily: "Cabin",
                                      fontSize: 20,
                                    ),
                                  ),
                                  TextFormField(
                                    // controller: addressController,
                                    onChanged: (val) {
                                      addressController.text = val;
                                      investorViewBalanceController.privateKey =
                                          val;
                                    },
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      InvestorDataBase().addAccountAddress(
                                          investorViewBalanceController
                                              .privateKey);
                                      investorViewBalanceController
                                          .getBalance();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Theme.of(context).primaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(20),
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "Save",
                                      style: TextStyle(
                                          fontFamily: "Cabin", fontSize: 20),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
      ),
    );
  }
}
