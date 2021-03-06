// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/image_picker_controller.dart';
import 'package:startupfunding/screens/start_screen.dart';
import 'package:startupfunding/screens/startup/investor_detail_screen.dart';
import 'package:startupfunding/widgets/custom_card.dart';

import '../../global.dart';
import 'investor_profile_management/investor_delete_account_screen.dart';
import 'investor_profile_management/investor_edit_profile_screen.dart';
import 'investor_profile_management/investor_view_balance_screen.dart';

class InvestorProfileScreen extends StatelessWidget {
  removeSharedPreferences() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    sharedPreferences.remove('title');
  }

  @override
  Widget build(BuildContext context) {
    print("Inside view profile screen");
    if (Get.find<InvestorGlobalController>().currentInvestor.firstName ==
        null) {
      print("First name is null");
    } else {
      print(
          "First name: ${Get.find<InvestorGlobalController>().currentInvestor.firstName}");
    }
    if (Get.find<InvestorGlobalController>().currentInvestor.lastName == null) {
      print("Last name is null");
    } else {
      print(
          "Last name: ${Get.find<InvestorGlobalController>().currentInvestor.lastName}");
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 180,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[
                      Color.fromRGBO(10, 102, 194, 0.9),
                      Color.fromRGBO(117, 104, 184, 1)
                    ]),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30)),
                color: Colors.deepPurpleAccent),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
                  child: fromSignup
                      ? CircleAvatar(
                          radius: 50.0,
                          backgroundImage: FileImage(
                              Get.find<ImagePickerController>()
                                  .choosenImage
                                  .value),
                          backgroundColor: Colors.grey,
                        )
                      : CircleAvatar(
                          radius: 50.0,
                          backgroundImage: CachedNetworkImageProvider(
                              Get.find<InvestorGlobalController>()
                                  .currentInvestor
                                  .investorImg!),
                          backgroundColor: Colors.grey,
                        ),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Get.find<InvestorGlobalController>()
                              .currentInvestor
                              .firstName! +
                          " " +
                          Get.find<InvestorGlobalController>()
                              .currentInvestor
                              .lastName!,
                      style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 25,
                          color: Colors.white),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "CEO of XYZ",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          InkWell(
              onTap: () {
                Get.to(InvestorDetailScreen(
                  fromReq: false,
                  investor:
                      Get.find<InvestorGlobalController>().currentInvestor,
                  viewProfile: true,
                ));
              },
              child: CustomCard(
                  iconImage: "assets/view_profile_icon.png",
                  title: "View Profile")),
          InkWell(
              onTap: () {
                Get.to(InvestorEditProfileScreen());
              },
              child: CustomCard(
                  iconImage: "assets/edit_profile_icon.png",
                  title: "Edit Profile")),
          InkWell(
              onTap: () {
                Get.to(InvestorViewBalanceScreen());
              },
              child: CustomCard(
                  iconImage: "assets/view_balance_icon.png",
                  title: "View Balance")),
          InkWell(
              onTap: () {
                // FirebaseAuth.instance.signOut();
                // Get.off(StartScreen());
                // removeSharedPreferences();

                Get.dialog(
                  AlertDialog(
                    title: Text(
                      'Log Out?',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                    ),
                    content: Text(
                      "Are you sure you want to log out and exit the app?",
                      style: TextStyle(
                        color: Color.fromRGBO(122, 122, 122, 1),
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text(
                          'No',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Get.back();

                          removeSharedPreferences();
                          FirebaseAuth.instance.signOut();
                          SystemNavigator.pop();
                        },
                        style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor),
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
              child: CustomCard(
                  iconImage: "assets/logout_icon.png", title: "Log Out")),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 50,
              width: 250,
              child: ElevatedButton(
                onPressed: () {
                  Get.to(InvestorDeleteAccScreen());
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    primary: Theme.of(context).primaryColor),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.delete),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Delete My Profile",
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
