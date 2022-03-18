import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/status_screen_controller.dart';

class InvestorViewStatusScreen extends StatefulWidget {
  final String workStreamId;
  InvestorViewStatusScreen({required this.workStreamId});

  @override
  State<InvestorViewStatusScreen> createState() =>
      _InvestorViewStatusScreenState();
}

class _InvestorViewStatusScreenState extends State<InvestorViewStatusScreen> {
  final StatusScreenController investorStatusScreenController =
      Get.put(StatusScreenController());

  @override
  void initState() {
    // TODO: implement initState
    investorStatusScreenController.getStatus(widget.workStreamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("data");
    print(investorStatusScreenController.currentStatus == {});
    print(investorStatusScreenController.currentStatus.isEmpty);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "View Status",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Cabin",
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Obx(
        () => investorStatusScreenController.isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : investorStatusScreenController.currentStatus.isEmpty
                ? Center(
                    child: Image(image: AssetImage("assets/not_found.jpeg")),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                            child: Container(
                              alignment: Alignment.bottomCenter,
                              child: Text(
                                "Current Status",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontFamily: "Cabin",
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        investorStatusScreenController
                                            .currentStatus['datetime'],
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: "Cabin",
                                          fontSize: 16,
                                        ),
                                      ),
                                      Text(
                                          investorStatusScreenController
                                              .currentStatus['statusDes'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Cabin",
                                            fontSize: 20,
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Divider(
                              color: Colors.grey,
                              height: 5,
                              thickness: 1.5,
                            ),
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                investorStatusScreenController.status.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  child: Card(
                                    elevation: 5,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            investorStatusScreenController
                                                .status[index]['datetime'],
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: "Cabin",
                                              fontSize: 16,
                                            ),
                                          ),
                                          Text(
                                              investorStatusScreenController
                                                  .status[index]['statusDes'],
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: "Cabin",
                                                fontSize: 20,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
      ),
    );
  }
}
