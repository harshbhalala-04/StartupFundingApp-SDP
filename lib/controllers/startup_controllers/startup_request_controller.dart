import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class StartupRequestController extends GetxController {
  final inviteRecievedList = [].obs;
  final inviteSentList = [].obs;
  final isLoading = false.obs;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final User? user = FirebaseAuth.instance.currentUser;

  removeRecievedInvestor(String uid) {
    inviteRecievedList.removeWhere((element) => element['id'] == uid);
  }

  fetchRequestUsers() async {
    isLoading.toggle();

    await firestore.collection("Startups").doc(user!.uid).get().then((value) {
      Map<String, dynamic> myMap = value.data()!;
      List<dynamic> myInviteList = myMap['inviteList'];
      if (myInviteList != null) {
        for (int i = 0; i < myInviteList.length; i++) {
          if (myInviteList[i]['recieved'] != "") {
            inviteRecievedList.add({
              "recieved": myInviteList[i]['recieved'],
              "id": myInviteList[i]['id'],
              "image": myInviteList[i]['image'],
              "time": myInviteList[i]['time'],
              "equity": myInviteList[i]['equity'],
              "amount": myInviteList[i]['amount'],
              "loanAmount": myInviteList[i]['loanAmount'],
              "roi": myInviteList[i]['roi'],
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
      }
    });
    inviteRecievedList.sort((a, b) => b["time"].compareTo(a["time"]));
    inviteSentList.sort((a, b) => b["time"].compareTo(a["time"]));
    print("#####################");
    for (int i = 0; i < inviteRecievedList.length; i++) {
      print(inviteRecievedList[i]);
    }
    for (int i = 0; i < inviteSentList.length; i++) {
      print(inviteSentList[i]);
    }
    print("#######################");
    isLoading.toggle();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    fetchRequestUsers();
    super.onInit();
  }
}
