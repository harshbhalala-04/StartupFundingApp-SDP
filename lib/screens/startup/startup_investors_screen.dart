// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';

import 'investor_detail_screen.dart';

class StartupInvestorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Obx(() => Get.find<StartupGlobalController>().isLoading.value
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ListView.builder(
            itemCount: Get.find<StartupGlobalController>().investersList.length,
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
                          Get.to(InvestorDetailScreen(
                            investor: Get.find<StartupGlobalController>()
                                .investersList[index],
                            fromReq: false,
                            viewProfile: false,
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
                                    Get.find<StartupGlobalController>()
                                        .investersList[index]
                                        .investorImg!,
                                  ),
                                  height: 300,
                                  fit: BoxFit.contain,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: 16, left: 16, bottom: 5),
                              child: Text(
                                "${Get.find<StartupGlobalController>().investersList[index].firstName}  ${Get.find<StartupGlobalController>().investersList[index].lastName}",
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
                                "CEO of XYZ",
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
                                Get.find<StartupGlobalController>()
                                    .investersList[index]
                                    .cityName!,
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
