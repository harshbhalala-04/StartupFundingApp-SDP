import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/upload_work_controller.dart';
import 'package:startupfunding/models/stage_model.dart';

class StageProofController extends GetxController {
  List<StageModel> stageList = [];
  final isLoading = false.obs;
  final UploadWorkController uploadWorkController =
      Get.put(UploadWorkController());
  fetchStage(String workStreamId) async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .where("approveStage", isEqualTo: true)
        .get()
        .then((val) {
      for (int i = 0; i < val.docs.length; i++) {
        stageList.add(StageModel.fromJson(val.docs[i].data()));
      }
    });
    isLoading.toggle();
  }
}
