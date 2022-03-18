// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadWorkController extends GetxController {
  final isImgUploaded = false.obs;
  final isVideoUploaded = false.obs;
  final isDocUploaded = false.obs;
  final isUrlUploaded = false.obs;
  final isLoading = false.obs;

  fetchUploadedInfo(String workStreamId, String stageId) async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageId)
        .get()
        .then((val) {
      if (val.data()!.containsKey("uploadedProofImg")) {
        isImgUploaded.value = val.data()!['uploadedProofImg'];
      }
      if (val.data()!.containsKey("uploadedProofDoc")) {
        isDocUploaded.value = val.data()!['uploadedProofDoc'];
      }
      if (val.data()!.containsKey("uploadedProofVideo")) {
        isVideoUploaded.value = val.data()!['uploadedProofVideo'];
      }
      if (val.data()!.containsKey("uploadedProofUrl")) {
        isUrlUploaded.value = val.data()!['uploadedProofUrl'];
      }
    });
    isLoading.toggle();
  }
}
