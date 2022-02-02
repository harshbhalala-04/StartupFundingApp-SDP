// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_request_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_request_controller.dart';
import 'package:startupfunding/controllers/workstream_section_controller/investor_workstream_controller.dart';
import 'package:startupfunding/controllers/workstream_section_controller/startup_workstream_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/models/investor_model.dart';
import 'package:startupfunding/models/startup_model.dart';

class ConfirmDialogue extends StatelessWidget {
  ConfirmDialogue(
      {required this.userType,
      this.startupUid,
      this.startupLogoUrl,
      this.startupName,
      this.investorFname,
      this.investorLname,
      this.investorImg,
      this.investorUid,
      this.startupModel,
      this.investorModel});
  final String userType;
  String? startupUid;
  String? startupLogoUrl;
  String? startupName;
  String? investorFname;
  String? investorLname;
  String? investorUid;
  String? investorImg;
  StartupModel? startupModel;
  InvestorModel? investorModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      child: AlertDialog(
        scrollable: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5,
              ),
              Text(
                'Accept the request and strike ',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              Text(
                'up a conversation!',
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    if (userType == "Startup") {
                      final StartupRequestController startupRequestController =
                          Get.put(StartupRequestController());
                      final StartupWorkStreamController startupWorkStreamController =
                          Get.put(StartupWorkStreamController());
                      // 1. Remove from pending list
                      startupRequestController
                          .removeRecievedInvestor(investorUid!);

                      // 2. Back to pending page
                      Get.back();
                      Get.back();

                      // Change from here############
                      Get.find<StartupWorkStreamController>()
                          .getInvestor(investorModel!);

                      // Create workstream
                      Get.find<StartupWorkStreamController>()
                          .createWorkStream();

                      // Send Informational Message
                      Get.find<StartupWorkStreamController>()
                          .addMessage("Workstream has been created", true);

                      // To here#################

                      // 3. Remove from database
                      StartupDataBase().removeInvestorFromPending(investorUid!);

                      // 4. Add User to MatchUsers
                      StartupDataBase().acceptOffer(
                          Get.find<StartupGlobalController>()
                              .currentStartup
                              .startupName!,
                          Get.find<StartupGlobalController>()
                              .currentStartup
                              .startupLogoUrl!,
                          investorFname! + " " + investorLname!,
                          investorImg!,
                          investorUid!);
                    } else {
                      final InvestorRequestController
                          investorRequestController =
                          Get.put(InvestorRequestController());
                      final InvestorWorkStreamController
                          investorWorkStreamController =
                          Get.put(InvestorWorkStreamController());
                      // 1. Remove from pending list
                      investorRequestController
                          .removeRecievedStartup(startupUid!);

                      // 2. Back to pending page
                      Get.back();
                      Get.back();

                      Get.find<InvestorWorkStreamController>()
                          .getStartup(startupModel!);
                      // Create workstream
                      Get.find<InvestorWorkStreamController>()
                          .createWorkStream();

                      // Send Informational Message
                      Get.find<InvestorWorkStreamController>()
                          .addMessage("Workstream has been created", true);

                      // 3. Remove from database
                      InvestorDataBase().removeStartupFromPending(startupUid!);

                      // 4. Add User to MatchUsers
                      InvestorDataBase().acceptOffer(
                          Get.find<InvestorGlobalController>()
                                  .currentInvestor
                                  .firstName! +
                              " " +
                              Get.find<InvestorGlobalController>()
                                  .currentInvestor
                                  .lastName!,
                          Get.find<InvestorGlobalController>()
                              .currentInvestor
                              .investorImg!,
                          startupName!,
                          startupLogoUrl!,
                          startupUid!);
                    }
                  },
                  child: Text(
                    'Accept',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      )),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'By clicking on “Accept” you will accept the request and workstream will be made.',
                style: TextStyle(color: Colors.black54, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
