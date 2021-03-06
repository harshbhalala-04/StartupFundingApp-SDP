import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';

class InvestorDataBase {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  addInvestorPersonalInfo(String firstName, String lastName, String linkedinUrl,
      String cityName) async {
    final InvestorGlobalController investorGlobalController =
        Get.put(InvestorGlobalController());

    investorGlobalController.currentInvestor.firstName = firstName;

    investorGlobalController.currentInvestor.lastName =  lastName;
    print("Inside database");
    print(investorGlobalController.currentInvestor.firstName);
    print(investorGlobalController.currentInvestor.lastName);

    await firestore.collection("Investors").doc(user!.uid).update({
      "firstName": firstName,
      "lastName": lastName,
      "linkedinUrl": linkedinUrl,
      "cityName": cityName
    });
  }

  addInvestorInvestmentDetails(String investedBefore, String category,
      List<String> experience, String assets) async {
    await firestore.collection("Investors").doc(user!.uid).update({
      "investedBefore": investedBefore,
      "category": category,
      "assets": assets,
      "experience": FieldValue.arrayUnion(experience)
    });
  }

  addInvestorPersonalizeInfo(List<Object?> expertise, String preferInvestment,
      String mentorStartup) async {
    await firestore.collection("Investors").doc(user!.uid).update({
      "expertise": FieldValue.arrayUnion(expertise),
      "preferInvestment": preferInvestment,
      "mentorStartup": mentorStartup,
    });
  }

  uploadInvestorImg(File userImages) async {
    if (userImages.path != '') {
      final ref = FirebaseStorage.instance
          .ref()
          .child('investor_img')
          .child(user!.uid + '.jpg');

      await ref.putFile(userImages).whenComplete(() => print('Image Upload'));

      String url = await ref.getDownloadURL();

      final InvestorGlobalController investorGlobalController =
          Get.put(InvestorGlobalController());

      investorGlobalController.currentInvestor.investorImg = url;

      await firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"investorImg": url});
    }
  }

  ///Add Startup to exclude list
  void addStartupToExcludeList(String startupUid, bool fromInvite) async {
    List<String> startupUidList = [];
    startupUidList.add(startupUid);

    try {
      await firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"excludeStartup": FieldValue.arrayUnion(startupUidList)});

      if (fromInvite) {
        List<String> investorUidList = [];
        investorUidList.add(user!.uid);
        await firestore.collection("Startups").doc(startupUid).update(
            {"excludeInvestor": FieldValue.arrayUnion(investorUidList)});
      }
    } catch (e) {
      print("Error info:          ");
      print(e);
    }
  }

  ///Add Startup to invite list
  void addStartupToInviteList(
      String startupUid,
      String startupImg,
      String startupName,
      String investorUid,
      String investorImg,
      String investorName,
      String equity,
      String amount,
      String loanAmount,
      String roi) async {
    DateTime time = DateTime.now();

    List<dynamic> myInviteList = [];
    List<dynamic> otherInviteList = [];

    try {
      await firestore.collection("Investors").doc(user!.uid).get().then((val) {
        myInviteList = val.data()!['inviteList'];
      });
      await firestore.collection("Startups").doc(startupUid).get().then((val) {
        otherInviteList = val.data()!['inviteList'];
      });

      List<Map<String, dynamic>> myMap = [
        {
          "time": time,
          "recieved": "",
          "sent": startupName,
          "image": startupImg,
          "id": startupUid,
          "equity": equity,
          "amount": amount,
          "loanAmount": loanAmount,
          "roi": roi,
        }
      ];

      List<Map<String, dynamic>> otherMap = [
        {
          "time": time,
          "recieved": investorName,
          "sent": "",
          "image": investorImg,
          "id": investorUid,
          "equity": equity,
          "amount": amount,
          "loanAmount": loanAmount,
          "roi": roi,
        }
      ];

      await firestore.collection("Investors").doc(user!.uid).update({
        'inviteList': FieldValue.arrayUnion(myMap),
        'latestConnectionSentUid': startupUid,
      });

      await firestore
          .collection("Startups")
          .doc(startupUid)
          .update({'inviteList': FieldValue.arrayUnion(otherMap)});
    } catch (e) {
      print("Error info");
      print(e);
    }
  }

  ///Remove Startup from pending list
  void removeStartupFromPending(String startupUid) async {
    try {
      await firestore
          .collection("Investors")
          .doc(user!.uid)
          .get()
          .then((value) {
        Map<String, dynamic> myMap = value.data()!;
        List<dynamic> inviteList = myMap['inviteList'];
        inviteList.removeWhere((element) => element['id'] == startupUid);

        firestore
            .collection("Investors")
            .doc(user!.uid)
            .update({"inviteList": inviteList});
      });

      await firestore
          .collection("Startups")
          .doc(startupUid)
          .get()
          .then((value) {
        Map<String, dynamic> myMap = value.data()!;
        List<dynamic> inviteList = myMap['inviteList'];
        inviteList.removeWhere((element) => element['id'] == user!.uid);

        firestore
            .collection("Startups")
            .doc(startupUid)
            .update({"inviteList": inviteList});
      });
    } catch (e) {
      print(e);
    }
  }

  ///Accept offer of Startup
  void acceptOffer(String investorName, String investorImg, String startupName,
      String startupLogo, String startupUid) async {
    DateTime time = DateTime.now();

    List<Map<String, dynamic>> myMatchMap = [
      {
        "friendname": startupName,
        "friendImage": startupLogo,
        "friendUid": startupUid
      }
    ];

    List<Map<String, dynamic>> otherMatchMap = [
      {
        "friendname": investorName,
        "friendImage": investorImg,
        "friendUid": user!.uid
      }
    ];

    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({'matchUsers': FieldValue.arrayUnion(myMatchMap)});

      firestore
          .collection("Startups")
          .doc(startupUid)
          .update({'matchUsers': FieldValue.arrayUnion(otherMatchMap)});
    } catch (e) {
      print(e.toString());
    }
  }

  addMessageMethod(
    String workStreamId,
    String messageId,
    Map<String, dynamic> messageInfo,
  ) async {
    try {
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("chats")
          .doc(messageId)
          .set(messageInfo);
    } catch (e) {
      print(e.toString());
    }
  }

  updateLastMessageSend(
      String workStreamId, Map<String, dynamic> lastMessageInfoMap) {
    try {
      return firestore
          .collection("workstream")
          .doc(workStreamId)
          .update(lastMessageInfoMap);
    } catch (e) {
      print(e.toString());
    }
  }

  ///Create workstream if not exists.
  createWorkstream(String workStreamId, workStreamMap) async {
    try {
      final snapshot =
          await firestore.collection("workstream").doc(workStreamId).get();

      //work stream Exists.
      if (snapshot.exists) {
        return true;
      }

      //workstream doesn't exists so create workstream.
      else {
        return firestore
            .collection("workstream")
            .doc(workStreamId)
            .set(workStreamMap)
            .catchError((e) {
          print(e.toString());
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  ///Get message of whole workstream
  getWorkStreamMessages(workStreamId) async {
    try {
      return firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("chats")
          .orderBy("ts", descending: true)
          .snapshots();
    } catch (e) {
      print(e.toString());
    }
  }

  void updateInvestorFirstName(String firstName) {
    Get.find<InvestorGlobalController>().currentInvestor.firstName = firstName;
    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"firstName": firstName});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateInvestorLastName(String lastName) {
    Get.find<InvestorGlobalController>().currentInvestor.lastName = lastName;
    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"lastName": lastName});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateInvestorPhoneNo(String phoneNo) {
    Get.find<InvestorGlobalController>().currentInvestor.phoneNo = phoneNo;
    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"phoneNo": phoneNo});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateInvestorEmail(String email) {
    Get.find<InvestorGlobalController>().currentInvestor.email = email;
    try {
      firestore.collection("Investors").doc(user!.uid).update({"email": email});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateInvestorLinkedinUrl(String linkedinUrl) {
    Get.find<InvestorGlobalController>().currentInvestor.linkedinUrl =
        linkedinUrl;
    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"linkedinUrl": linkedinUrl});
    } catch (e) {
      print(e.toString());
    }
  }

  void updateInvestorCityName(String cityName) {
    Get.find<InvestorGlobalController>().currentInvestor.cityName = cityName;
    try {
      firestore
          .collection("Investors")
          .doc(user!.uid)
          .update({"cityName": cityName});
    } catch (e) {
      print(e.toString());
    }
  }

  void approveStage(int stageIndex, String workStreamId) async {
    try {
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("stages")
          .doc("stage " + stageIndex.toString())
          .update({"approveStage": true});
    } catch (e) {
      print(e.toString());
    }
  }

  void rejectStage(int stageIndex, String workStreamId, String feedBack) async {
    try {
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("stages")
          .doc("stage " + stageIndex.toString())
          .update({
        "approveStage": false,
        "feedBack": feedBack,
      });
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .update({"submitStage": false});
    } catch (e) {
      print(e.toString());
    }
  }

  void addStageVerify(String workStreamId, String statusDes) async {
    try {
      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .update({"verifiedStage": true});

      Map<String, dynamic> status = {};
      status['timestamp'] = Timestamp.now();
      status['statusDes'] = statusDes;

      await firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("status")
          .doc()
          .set(status);
    } catch (e) {
      print(e.toString());
    }
  }

  void rejectStageFunding(String workStreamId, String stageTitle) async {
    print(stageTitle);
    await firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .where("stageTitle", isEqualTo: stageTitle)
        .get()
        .then((val) {
      Map<String, dynamic> tmpMap = val.docs[0].data();
      tmpMap['pendingRequest'] = false;
      tmpMap['approvedRequest'] = false;
      print(tmpMap['stageId']);
      firestore
          .collection("workstream")
          .doc(workStreamId)
          .collection("stages")
          .doc(tmpMap['stageId'])
          .update(tmpMap);
    });
  }

  verificationRejected(String workStreamId, String stageId) async {
    await firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageId)
        .update({"verificationPending": false, "verificationRejected": true});
  }

  verificationApproved(String workStreamId, String stageId) async {
    await firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageId)
        .update({"verificationPending": false, "verificationApproved": true});
  }

  addAccountAddress(String privateKey) async {
    await firestore
        .collection("Investors")
        .doc(user!.uid)
        .update({"accountAddress": privateKey, "accountProvided": true});
  }

  addPaymentInformation(String ownAddress, String reciever, String amount,
      String workStreamId, String stageId, String txHash) {
    final timestamp = Timestamp.now();
    firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("transactions")
        .doc()
        .set({
      "from": ownAddress,
      "to": reciever,
      "amount": amount,
      "timestamp": timestamp,
      "stageId": stageId,
      "txHash": txHash,
    });

    firestore
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageId)
        .update({
      "fundingProvided": true,
      "pendingRequest": false,
      "approvedRequest": true
    });
  }
}
