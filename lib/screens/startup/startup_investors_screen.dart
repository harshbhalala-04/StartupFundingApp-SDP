// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'investor_detail_screen.dart';

class StartupInvestorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 5,
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
                      Get.to(InvestorDetailScreen());
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Stack(
                          children: [
                            Ink.image(
                              image: AssetImage("assets/test_image.png"),
                              height: 300,
                              fit: BoxFit.contain,
                            ),
                          ],
                        ),
                        Padding(
                          padding:
                              EdgeInsets.only(top: 16, left: 16, bottom: 5),
                          child: Text(
                            "ABC",
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
                          padding: EdgeInsets.only(top: 5, left: 16, bottom: 5),
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
                          padding: EdgeInsets.only(top: 5, left: 16, bottom: 5),
                          child: Text(
                            "City",
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
        });
  }
}
