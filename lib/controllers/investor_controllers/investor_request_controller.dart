import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class InvestorRequestController extends GetxController {
  final inviteRecievedList = [].obs;
  final inviteSentList = [].obs;
  final isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  removeRecievedStartup(String uid) {
    inviteRecievedList.removeWhere((element) => element['id'] == uid);
  }

  fetchRequestUsers() async {
    isLoading.toggle();

    await firestore.collection("Investors").doc(user!.uid).get().then((value) {
      Map<String, dynamic> myMap = value.data()!;
      List<dynamic> myInviteList = myMap['inviteList'];
      if (myInviteList != null && myInviteList.isNotEmpty) {
        for (int i = 0; i < myInviteList.length; i++) {
          if (myInviteList[i]['recieved'] != "") {
            inviteRecievedList.add({
              "recieved": myInviteList[i]['recieved'],
              "id": myInviteList[i]['id'],
              "image": myInviteList[i]['image'],
              "time": myInviteList[i]['time']
            });
          } else if (myInviteList[i]['sent'] != "") {
            inviteSentList.add({
              "sent": myInviteList[i]['sent'],
              "id": myInviteList[i]['id'],
              "image": myInviteList[i]['image'],
              "time": myInviteList[i]['time']
            });
          }
        }
        inviteRecievedList.sort((a, b) => b["time"].compareTo(a["time"]));
        inviteSentList.sort((a, b) => b["time"].compareTo(a["time"]));
      }
    });

    for (int i = 0; i < inviteRecievedList.length; i++) {
      print(inviteRecievedList[i]);
    }
    for (int i = 0; i < inviteSentList.length; i++) {
      print(inviteSentList[i]);
    }
    isLoading.toggle();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchRequestUsers();
    super.onInit();
  }
}
