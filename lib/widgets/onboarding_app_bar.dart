import 'package:flutter/material.dart';

class OnBoardingAppBarTitle extends StatelessWidget {
  const OnBoardingAppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      'Startup Funding',
      style: TextStyle(
        color: Theme.of(context).primaryColor,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        fontFamily: "Cabin",
      ),
    );
  }
}
