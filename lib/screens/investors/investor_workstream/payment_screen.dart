// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_new

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_payment_controller.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_view_balance_controller.dart';
import 'package:startupfunding/screens/investors/investor_workstream/payment_confirm_screen.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';
import 'package:startupfunding/widgets/onboarding_app_bar.dart';

import '../../../database/investor_database.dart';

class PaymentScreen extends StatefulWidget {
  final String workStreamId;
  final String stageId;
  final String fundingAmount;

  PaymentScreen(
      {required this.workStreamId,
      required this.stageId,
      required this.fundingAmount});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final InvestorPaymentController investorPaymentController =
      Get.put(InvestorPaymentController());

  final TextEditingController addressController = new TextEditingController();
  final TextEditingController amountController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    investorPaymentController.checkKey();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Transfer Money',
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: "Cabin",
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
        ),
        body: Obx(
          () => investorPaymentController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Obx(
                  () => investorPaymentController.isAccAvailable.value
                      ? Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Image(
                                      width: 50,
                                      height: 50,
                                      image: AssetImage("assets/ether.png"),
                                    ),
                                    Text(
                                      investorPaymentController
                                              .accountBalance.value +
                                          " ether",
                                      style: TextStyle(
                                        fontFamily: "Cabin",
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "From Wallet",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Cabin"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  initialValue: "My Wallet",
                                  readOnly: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "Cabin"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "To Wallet Address",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Cabin"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  controller: addressController,
                                  decoration: InputDecoration(
                                    hintText: "Enter wallet address",
                                    hintStyle: TextStyle(
                                        fontFamily: "Cabin",
                                        fontSize: 14,
                                        color: Colors.grey),
                                  ),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      fontFamily: "Cabin"),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "Amount",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      fontFamily: "Cabin"),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                TextFormField(
                                  initialValue: widget.fundingAmount,
                                  readOnly: true,
                                  style: TextStyle(
                                      color: Colors.black,
                                      // fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      fontFamily: "Cabin"),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                Center(
                                  child: Obx(
                                    () => investorPaymentController
                                            .isPaymentProcess.value
                                        ? CircularProgressIndicator()
                                        : ElevatedButton(
                                            onPressed: () {
                                              print(addressController.text);
                                              
                                              if (addressController.text ==
                                                  "") {
                                                createAlertDialogue(
                                                    "Please enter other address");
                                                return;
                                              }
                                             
                                              investorPaymentController
                                                  .sendEther(
                                                      addressController.text,
                                                      widget.fundingAmount,
                                                      widget.workStreamId,
                                                      widget.stageId);
                                            },
                                            style: ElevatedButton.styleFrom(
                                                primary: Theme.of(context)
                                                    .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(20),
                                                  ),
                                                )),
                                            child: Text(
                                              "  Pay Now  ",
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontFamily: "Cabin"),
                                            ),
                                          ),
                                  ),
                                ),
                              ],
                            ),
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
                                        investorPaymentController
                                            .privateKey.value = val;
                                      },
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        InvestorDataBase().addAccountAddress(
                                            investorPaymentController
                                                .privateKey.value);
                                        investorPaymentController
                                            .isAccAvailable.value = true;
                                        investorPaymentController.getBalance();
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
        ));
  }
}
