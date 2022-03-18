import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:startupfunding/controllers/startup_controllers/upload_work_controller.dart';

class ProofImagePickerController extends GetxController {
  final isLoading = false.obs;
  final loadInit = false.obs;
  String? imgUrl = "";
  File? pickedImageVar;
  List<File> choosenImage = [
    File(''),
    File(''),
    File(''),
    File(''),
  ].obs;
  List<String> networkImg = ["", "", "", ""];
  List<bool> isUploadedImage = [false, false, false, false].obs;
  final uploadedProofImg = false.obs;

  fetchImage(String stageUid, String workStreamId) async {
    loadInit.toggle();
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageUid)
        .get()
        .then((val) {
      if (val.data()!['uploadedProofImg'] != null) {
        uploadedProofImg.value = val.data()!['uploadedProofImg'];
      }
      print("12345");
      print(uploadedProofImg.value);
      if (uploadedProofImg.value) {
        Map<String, dynamic> tmpMap = val.data()!['proof_of_work'];
        if (tmpMap.containsKey('photos')) {
          for (int i = 0; i < tmpMap['photos'].length; i++) {
            networkImg[i] = tmpMap['photos'][i];
          }
        }
      }
    });
    loadInit.toggle();
  }

  void pickImage(BuildContext context, int index) async {
    print('This is Proof picked image controller : ${isLoading.value}');
    ImageSource? imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Upload Your Proof Image'),
        actions: [
          MaterialButton(
            child: Text('Camera'),
            onPressed: () => Navigator.pop(context, ImageSource.camera),
            textColor: Theme.of(context).primaryColor,
          ),
          MaterialButton(
            child: Text('Gallery'),
            onPressed: () => Navigator.pop(context, ImageSource.gallery),
            textColor: Theme.of(context).primaryColor,
          ),
        ],
      ),
    );

    if (imageSource != null) {
      isLoading.toggle();

      final _picker = ImagePicker();

      final XFile? pickedImageFile = await _picker.pickImage(
        source: imageSource,
        // imageQuality: 50,
        // maxWidth: 1400,
        // maxHeight: 1400,
      );

      if (pickedImageFile == null) {
        isLoading.toggle();
      } else {
        File file = File(pickedImageFile.path);
        print(file);

        choosenImage[index] = file;
        isUploadedImage[index] = true;
        isLoading.toggle();
      }
    }
  }
}
