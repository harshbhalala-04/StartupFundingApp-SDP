import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StartupDataBase {
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

  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  void addPitchDeckUrl(String url) async {
    await firestore
        .collection("Startups")
        .doc(user!.uid)
        .update({"pitchDeckUrl": url});
  }

  uploadUserImages(File userImages, String folderTitle) async {
    if (userImages.path != '') {
      final ref = FirebaseStorage.instance
          .ref()
          .child('startup_img')
          .child(folderTitle)
          .child(user!.uid + folderTitle + '.jpg');

      await ref.putFile(userImages).whenComplete(() => print('Image Upload'));

      String url = await ref.getDownloadURL();
      print("This is uploaded img url: $url");
      print("_________________________");
      if (folderTitle == "startupLogo") {
        await firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"startupLogoUrl": url});
      } else if (folderTitle == "Founder") {
        await firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"founderImg": url});
      } else if (folderTitle == "Co-Founder") {
        await firestore
            .collection("Startups")
            .doc(user!.uid)
            .update({"coFounderImg": url});
      }
    }
  }
}
