// ignore_for_file: prefer_const_constructors, unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/global.dart';
import 'package:startupfunding/notificationHandler.dart';
import 'package:startupfunding/screens/auth_screen.dart';
import 'package:startupfunding/screens/investors/investor_home_screen.dart';
import 'package:startupfunding/screens/investors/investor_onboarding_screen/investor_investment_profile_screen.dart';
import 'package:startupfunding/screens/investors/investor_onboarding_screen/investor_personal_info_screen.dart';
import 'package:startupfunding/screens/startup/startup_home_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/linkedin_url_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/pitch_deck_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/single_founder_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/user_name_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/verify_phone_screen.dart';
import 'package:startupfunding/screens/user_profile_screen.dart';
import 'controllers/bindings/authBinding.dart';
import 'screens/start_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // App is terminated
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // App is closed but not terminated(It is inside RAM)
  FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
    await handleNetworkNotification(message);
  });

  // App is opened
  FirebaseMessaging.onMessageOpenedApp.listen((message) async {});

  initializeLocalNotification();  
  runApp(const MyApp());
}

int flag = 0;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    initDynamicLinks();
    getUserType();
    super.initState();
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;
    var uid;

    if (deepLink != null) {
      uid = deepLink.path.substring(1);
      if (FirebaseAuth.instance.currentUser != null) {
        Get.to(UserProfileScreen(
          uid: uid,
        ));
      }
    }

    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
      final Uri? deepLink = dynamicLink?.link;

      if (deepLink != null) {
        uid = deepLink.path.substring(1);
        if (FirebaseAuth.instance.currentUser != null) {
          Get.to(UserProfileScreen(
            uid: uid,
          ));
        }
      }
    }, onError: (OnLinkErrorException e) async {
      print(e.message);
    });
  }

  getUserType() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    setState(() {
      userType = sharedPreferences.getString('title');
      print(userType);
      print(")))))))))))))))))))))))))))");
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
