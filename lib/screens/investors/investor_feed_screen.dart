// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/screens/investors/startup_detail_screen.dart';

class InvestorFeedScreen extends StatelessWidget {
  const InvestorFeedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.find<InvestorGlobalController>().isLoading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: Get.find<InvestorGlobalController>().startupsList.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: InkWell(
                        onTap: () {
                          Get.to(StartupDetailScreen(
                            startup:  Get.find<InvestorGlobalController>().startupsList[index],
                            fromReq: false,
                          ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Ink.image(
                                  image: CachedNetworkImageProvider(
                                      Get.find<InvestorGlobalController>()
                                          .startupsList[index]
                                          .startupLogoUrl!),
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 16, left: 16, bottom: 5),
                              child: Text(
                                Get.find<InvestorGlobalController>()
                                    .startupsList[index]
                                    .startupName!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontFamily: 'Cabin',
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 5, left: 16, bottom: 5),
                              child: Text(
                                Get.find<InvestorGlobalController>()
                                    .startupsList[index]
                                    .startupCity!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontFamily: 'Cabin',
                                  letterSpacing: 1,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 5, left: 16, bottom: 5),
                              child: Text(
                                Get.find<InvestorGlobalController>()
                                    .startupsList[index]
                                    .startupCategory!,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20,
                                  fontFamily: 'Cabin',
                                  letterSpacing: 1,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }
}
