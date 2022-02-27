// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/status_screen_controller.dart';

class ViewStatusScreen extends StatefulWidget {
  final String workStreamId;
  ViewStatusScreen({required this.workStreamId});

  @override
  State<ViewStatusScreen> createState() => _ViewStatusScreenState();
}

class _ViewStatusScreenState extends State<ViewStatusScreen> {
  final StatusScreenController statusScreenController =
      Get.put(StatusScreenController());

  @override
  void initState() {
    // TODO: implement initState
    statusScreenController.getStatus(widget.workStreamId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
          () => statusScreenController.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Current Status",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontFamily: "Cabin",
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      statusScreenController
                                          .currentStatus['datetime'],
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: "Cabin",
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                        statusScreenController
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
                          itemCount: statusScreenController.status.length,
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
                                          statusScreenController.status[index]
                                              ['datetime'],
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: "Cabin",
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                            statusScreenController.status[index]
                                                ['statusDes'],
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
        ));
  }
}
