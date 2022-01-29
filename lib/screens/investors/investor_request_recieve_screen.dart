// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_request_controller.dart';
import 'package:startupfunding/screens/investors/startup_detail_screen.dart';
import 'package:startupfunding/widgets/user_card.dart';

class InvestorRequestRecieveScreen extends StatelessWidget {
  const InvestorRequestRecieveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() =>  SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                'Recieved Invitations ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Obx(() =>  Text(
                  '(' +
                      Get.find<InvestorRequestController>()
                          .inviteRecievedList
                          .length
                          .toString() +
                      ')',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  ))),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
              Get.find<InvestorRequestController>().inviteRecievedList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Get.to(StartupDetailScreen(
                      fromReq: true,
                      uid: Get.find<InvestorRequestController>()
                          .inviteRecievedList[index]["id"]));
                },
                child: UserCard(
                  imgUrl: Get.find<InvestorRequestController>()
                      .inviteRecievedList[index]["image"],
                  title: Get.find<InvestorRequestController>()
                      .inviteRecievedList[index]['recieved'],
                ));
          },
        ),
      ]),
    ));
  }
}
