// ignore_for_file: unnecessary_new
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/models/startup_model.dart';

class InvestorWorkStreamController extends GetxController {
  String? workStreamId;
  String myUserName =
      Get.find<InvestorGlobalController>().currentInvestor.firstName! +
          " " +
          Get.find<InvestorGlobalController>().currentInvestor.lastName!;

  String myUserId = Get.find<InvestorGlobalController>().currentInvestor.uid!;
  String otherUserId = '';

  String? messageId = '';
  final currentStartup = StartupModel().obs;
  final isLoading = false.obs;

  getStartup(StartupModel startupModel) {
    currentStartup.value = startupModel;
  }

  getChatRoomId(String a, String b) {
    if (a.substring(0, 1).codeUnitAt(0) > b.substring(0, 1).codeUnitAt(0)) {
      return "$b\_$a";
    } else {
      return "$a\_$b";
    }
  }

  createWorkStream() async {
    String otherUsername = currentStartup.value.startupName!;
    List<String> users = [myUserName, otherUsername];
    List<String> userIds = [myUserId, currentStartup.value.uid!];

    // List<String> usersSort = users;
    // usersSort.sort();

    workStreamId = getChatRoomId(myUserId, currentStartup.value.uid!);

    Map<String, dynamic> workStreamMap = {
      "workStreamId": workStreamId,
      "userIds": userIds,
      "firstUserName": users[0],
      "secondUserName": users[1],
      "firstUserImg":
          Get.find<InvestorGlobalController>().currentInvestor.investorImg,
      "secondUserImg": currentStartup.value.startupLogoUrl,
      "firstUserUid": Get.find<InvestorGlobalController>().currentInvestor.uid,
      "secondUserUid": currentStartup.value.uid,
    };

    InvestorDataBase().createWorkstream(workStreamId!, workStreamMap);
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
      "otherUserUid": infoMsg ? "" : currentStartup.value.uid,
    };

    //message ID
    if (messageId == '') {
      messageId = getMessageId();
    }

    InvestorDataBase()
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

      InvestorDataBase()
          .updateLastMessageSend(workStreamId!, lastMessageInfoMap);
      messageId = '';
    });
  }
}
