// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// class ProofVideoPickerController extends GetxController {
//   final isLoading = false.obs;
//   // String? imgUrl = "";
//   // File? pickedImageVar;
//   // final choosenImage = File("").obs;
//   // final isUploadedImage = false.obs;
//   File? _video;
//   final picker = ImagePicker();

//   // void pickVideo(
   
//   // ) async {
//   //   print('This is Proof picked Video controller : ${isLoading.value}');
//   //   PickedFile pickedFile = await picker.getVideo(source: ImageSource.gallery);
//   //    _video = File(pickedFile.path); 
//   //   _videoPlayerController = VideoPlayerController.file(_video)..initialize().then((_) {
//   //     setState(() { });
//   //     _videoPlayerController.play();
//   //   });
//     // ImageSource? imageSource = await showDialog<ImageSource>(
//     //   context: context,
//     //   builder: (ctx) => AlertDialog(
//     //     title: Text('Upload Your Proof Video'),
//     //     actions: [
//     //       MaterialButton(
//     //         child: Text('Camera'),
//     //         onPressed: () => Navigator.pop(context, ImageSource.camera),
//     //         textColor: Theme.of(context).primaryColor,
//     //       ),
//     //       MaterialButton(
//     //         child: Text('Gallery'),
//     //         onPressed: () => Navigator.pop(context, ImageSource.gallery),
//     //         textColor: Theme.of(context).primaryColor,
//     //       ),
//     //     ],
//     //   ),
//     // );

//     // if (imageSource != null) {
//     //   isLoading.toggle();

//     //   final _picker = ImagePicker();

//     //   final XFile? pickedImageFile = await _picker.pickImage(
//     //     source: imageSource,
//     //     // imageQuality: 50,
//     //     // maxWidth: 1400,
//     //     // maxHeight: 1400,
//     //   );

//       // if (pickedImageFile == null) {
//       //   isLoading.toggle();
//       // } else {
//       //   File file = File(pickedImageFile.path);
//       //   print(file);

//       //   choosenImage.value = file;
//       //   isUploadedImage.value = true;
//       //   isLoading.toggle();
//       // }
//     }
//   }
// }
