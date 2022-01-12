import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataBase {
  final FirebaseAuth? auth = FirebaseAuth.instance;
  final User? user = FirebaseAuth.instance.currentUser;
  final firestore = FirebaseFirestore.instance;

  void addUserName(String name) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"userName": name});
  }

  void addStartupName(String name) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupName": name});
  }

  void addRegStartupName(String name) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"regStartupName": name});
  }

  void addWebAppUrl(String url) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"webAppUrl": url});
  }

  void addLinkedinUrl(String url) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"linkedinUrl": url});
  }

  void addFounderInfo(String reply, String secondFounderName,
      String secondFounderEmail, String secondFounderLinkedinUrl) async {
    print("reply value");
    print(reply);
    if (reply == "Yes") {
      await firestore
          .collection("Startups")
          .doc(user!.uid)
          .update({"singleUser": "Yes"});
    } else {
      await firestore.collection("Startups").doc(user!.uid).update({
        "singleUser": "No",
        "secondFounderName": secondFounderName,
        "secondFounderEmail": secondFounderEmail,
        "secondFounderLinkedinUrl": secondFounderLinkedinUrl
      });
    }
  }

  void addStartupCategory(String category) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupCategory": category});
  }

  void addStartupDescription(String description) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupDescription": description});
  }

  void addStartupCityName(String city) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupCity": city});
  }

  void addStartupStage(String stage) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"startupStage": stage});
  }
}
