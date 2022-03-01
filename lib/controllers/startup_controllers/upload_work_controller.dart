// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class UploadWorkController extends GetxController {
  final uploadWorkImg = [File(""), File(""), File(""), File("")].obs;
  List<File> choosenWorkImg = [File(""), File(""), File(""), File("")].obs;
  List<bool> isUploadedImage = [false, false, false, false].obs;
  final isLoading = false.obs;

  Future cropImage(File pickedImage) async {
    try {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedImage.path,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              lockAspectRatio: false),
          compressQuality: 50,
          iosUiSettings: IOSUiSettings(
            title: 'Crop Image',
          ));
      if (croppedFile != null) {
        pickedImage = croppedFile;
      }
      return pickedImage;
    } catch (e) {
      print(e);
    }
  }

  void pickImage(BuildContext context, int index) async {
    ImageSource? imageSource = await showDialog<ImageSource>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Upload Your Image'),
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
        imageQuality: 50,
        maxWidth: 1400,
        maxHeight: 1400,
      );

      if (pickedImageFile == null) {
        isLoading.toggle();
      } else {
        File file = File(pickedImageFile.path);

        choosenWorkImg[index] = file;

        isUploadedImage[index] = true;
        isLoading.toggle();
      }
    }
  }

  
}
