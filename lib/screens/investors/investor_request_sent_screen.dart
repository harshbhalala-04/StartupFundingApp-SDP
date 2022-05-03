// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_request_controller.dart';
import 'package:startupfunding/widgets/user_card.dart';

class InvestorRequestSentScreen extends StatelessWidget {
  const InvestorRequestSentScreen({Key? key}) : super(key: key);

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
                      Get.find<InvestorRequestController>()
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
          itemCount:
              Get.find<InvestorRequestController>().inviteSentList.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {},
                child: UserCard(
                  imgUrl: Get.find<InvestorRequestController>()
                      .inviteSentList[index]["image"],
                  title: Get.find<InvestorRequestController>()
                      .inviteSentList[index]['sent'],
                      startupReqRecieve: false,
                ));
          },
        ),
      ]),
    );
  }
}
