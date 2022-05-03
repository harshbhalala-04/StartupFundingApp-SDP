// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_request_controller.dart';
import 'package:startupfunding/widgets/user_card.dart';

class StartupRequestSentScreen extends StatelessWidget {
  const StartupRequestSentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                'Sent Invitations ',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromRGBO(51, 51, 51, 1),
                ),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                  '(' +
                      Get.find<StartupRequestController>()
                          .inviteSentList
                          .length
                          .toString() +
                      ')',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(51, 51, 51, 1),
                  )),
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: Get.find<StartupRequestController>().inviteSentList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
              child: UserCard(
                  imgUrl: Get.find<StartupRequestController>()
                      .inviteSentList[index]["image"],
                  title: Get.find<StartupRequestController>()
                      .inviteSentList[index]['sent'],
                      startupReqRecieve: false,
                )
            );
          },
        ),
      ]),
    );
  }
}
