import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/startup_controllers/view_funding_controller.dart';

class InvestorProvidedFundingScreen extends StatefulWidget {
  final String workStreamId;
  InvestorProvidedFundingScreen({required this.workStreamId});
  @override
  State<InvestorProvidedFundingScreen> createState() =>
      _InvestorProvidedFundingScreenState();
}

class _InvestorProvidedFundingScreenState
    extends State<InvestorProvidedFundingScreen> {

  final ViewFundingController viewFundingController =
      Get.put(ViewFundingController());

  @override
  void initState() {
    // TODO: implement initState
    viewFundingController.fetchFundingProvidedStages(widget.workStreamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Provided Funding",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "Cabin",
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(() => viewFundingController.isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: viewFundingController.transactionList.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ExpandablePanel(
                          header: Text(
                            "Funding amount: ${viewFundingController.transactionList[index].amount} ether",
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 20,
                            ),
                          ),
                          collapsed: Text(
                            "From Account: ${viewFundingController.transactionList[index].from}",
                            softWrap: true,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontFamily: "Cabin",
                              fontSize: 17,
                            ),
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "From Account: ${viewFundingController.transactionList[index].from}",
                                style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "To Account: ${viewFundingController.transactionList[index].to}",
                                softWrap: true,
                                style: TextStyle(
                                    fontFamily: "Cabin",
                                    fontSize: 17,
                                    color: Colors.black),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Transaction Hash: ${viewFundingController.transactionList[index].txHash}",
                                softWrap: true,
                                style: TextStyle(
                                  fontFamily: "Cabin",
                                  fontSize: 17,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                          theme: ExpandableThemeData(
                            iconColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}
