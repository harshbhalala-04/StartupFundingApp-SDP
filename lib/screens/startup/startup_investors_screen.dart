import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'investor_detail_screen.dart';

class StartupInvestorsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        
        body: Center(
            child: Container(
          width: 350,
          height: 400,
          child: InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => InvestorDetailScreen()));
            },
            child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.asset(
                          "assets/test_image.png",
                          fit: BoxFit.cover,
                          height: 240,
                          width: 300,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("ABC DEF \n CEO xyz \n City"),
                  ],
                )),
          ),
        )),
      );
}
