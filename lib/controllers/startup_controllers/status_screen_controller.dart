import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class StatusScreenController extends GetxController {
  final isLoading = false.obs;
  final currentStatus = {}.obs;
  final status = [].obs;

  getStatus(String workStreamId) async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("status")
        .orderBy("timestamp", descending: true)
        .get()
        .then((val) {
      print("values: ");
      print(val.docs.length);
      for (int i = 0; i < val.docs.length; i++) {
        if (i == 0) {
          Timestamp timestamp = val.docs[i].data()['timestamp'];
          DateTime dt = timestamp.toDate();

          currentStatus['datetime'] = dt.day.toString() +
              "/" +
              dt.month.toString() +
              "/" +
              dt.year.toString() +
              " " +
              dt.hour.toString() +
              ":" +
              dt.minute.toString();
          currentStatus['statusDes'] = val.docs[i].data()['statusDes'];
        } else {
          Timestamp timestamp = val.docs[i].data()['timestamp'];
          DateTime dt = timestamp.toDate();

          String time = dt.day.toString() +
              "/" +
              dt.month.toString() +
              "/" +
              dt.year.toString() +
              " " +
              dt.hour.toString() +
              ":" +
              dt.minute.toString();
          status.add(
              {"datetime": time, "statusDes": val.docs[i].data()['statusDes']});
        }
      }
    });
    isLoading.toggle();
  }
}
