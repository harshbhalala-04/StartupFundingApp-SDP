// ignore_for_file: unnecessary_new

import 'dart:math';

import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/models/investor_model.dart';

class StartupWorkStreamController extends GetxController {
  String? workStreamId;
  String myUserName =
      Get.find<StartupGlobalController>().currentStartup.startupName!;

  String myUserId = Get.find<StartupGlobalController>().currentStartup.uid!;
  String otherUserId = '';

  String? messageId = '';
  final currentInvestor = InvestorModel().obs;
  final isLoading = false.obs;

  getInvestor(InvestorModel investorModel) {
    currentInvestor.value = investorModel;
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createWorkStream() async {
    String otherUsername = currentInvestor.value.firstName! +
        " " +
        currentInvestor.value.lastName!;
    List<String> users = [myUserName, otherUsername];
    List<String> userIds = [myUserId, currentInvestor.value.uid!];

    // List<String> usersSort = users;
    // usersSort.sort();

    workStreamId = getChatRoomId(myUserId, currentInvestor.value.uid!);

    Map<String, dynamic> workStreamMap = {
      "workStreamId": workStreamId,
      "userIds": userIds,
      "firstUserName": users[0],
      "secondUserName": users[1],
      "firstUserImg":
          Get.find<StartupGlobalController>().currentStartup.startupLogoUrl,
      "secondUserImg": currentInvestor.value.investorImg,
      "firstUserUid": Get.find<StartupGlobalController>().currentStartup.uid,
      "secondUserUid": currentInvestor.value.uid,
      "stageCreated": false
    };

    StartupDataBase().createWorkstream(workStreamId!, workStreamMap);
  }

  String getMessageId() {
    const chars = "abcdefghijklmnopqrstuvwxyz0123456789";
    Random rnd = new Random(new DateTime.now().millisecondsSinceEpoch);
    String result = "";
    for (var i = 0; i < 12; i++) {
      result += chars[rnd.nextInt(chars.length)];
    }
    return result;
  }

  addMessage(String enterdMessage, bool infoMsg) {
    String message = enterdMessage;
    var lastMessageTs = DateTime.now();

    Map<String, dynamic> messageInfoMap = {
      "message": message,
      "sendBy": infoMsg ? "" : myUserId,
      "ts": lastMessageTs,
      "otherUserUid": infoMsg ? "" : currentInvestor.value.uid,
    };

    //message ID
    if (messageId == '') {
      messageId = getMessageId();
    }

    StartupDataBase()
        .addMessageMethod(
      workStreamId!,
      messageId!,
      messageInfoMap,
    )
        .then((val) {
      Map<String, dynamic> lastMessageInfoMap = {
        "lastMessage": message,
        "lastMessageTs": lastMessageTs,
      };

      StartupDataBase()
          .updateLastMessageSend(workStreamId!, lastMessageInfoMap);
      messageId = '';
    });
  }
}
