// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/screens/auth_screen.dart';
import 'package:startupfunding/screens/investors/investor_home_screen.dart';
import 'package:startupfunding/screens/startup/startup_home_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/linkedin_url_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/pitch_deck_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/verify_phone_screen.dart';
import 'controllers/bindings/authBinding.dart';
import 'screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

int flag = 0;
String? userType;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    getUserType();
    super.initState();
  }

  getUserType() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      userType = sharedPreferences.getString('title');
      flag = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AuthBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: "Cabin",
          primarySwatch: Colors.indigo,
          primaryColor: const Color.fromRGBO(117, 104, 177, 1)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, userSnapshot) {
          if (userSnapshot.hasData) {
            if (flag == 0) {
              return CircularProgressIndicator();
            } else {
              if (userType == 'Startup') {
                return StartupHomeScreen();
              } else {
                return InvestorHomeScreen();
              }
            }
          } else {
            return StartScreen();
          }
        },
      ),
    );
  }
}
