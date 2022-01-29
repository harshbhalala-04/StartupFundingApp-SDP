// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_request_controller.dart';
import 'package:startupfunding/screens/startup/investor_detail_screen.dart';
import 'package:startupfunding/widgets/user_card.dart';

class StartupRequestRecieveScreen extends StatelessWidget {
  const StartupRequestRecieveScreen({Key? key}) : super(key: key);

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
                      Get.find<StartupRequestController>()
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
              Get.find<StartupRequestController>().inviteRecievedList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Get.to(InvestorDetailScreen(
                    uid: Get.find<StartupRequestController>()
                        .inviteRecievedList[index]["id"],
                    fromReq: true,
                  ));
                },
                child: UserCard(
                  imgUrl: Get.find<StartupRequestController>()
                      .inviteRecievedList[index]["image"],
                  title: Get.find<StartupRequestController>()
                      .inviteRecievedList[index]['recieved'],
                ));
          },
        ),
      ]),
    ));
  }
}
