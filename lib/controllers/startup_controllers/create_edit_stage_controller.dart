import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/models/stage_model.dart';

class CreateEditStageController extends GetxController {
  final RxList<dynamic> stageList = [].obs;
  final isStageSubmitted = false.obs;

  final isApproved = [].obs;
  final feedBackList = [].obs;

  final isVerified = false.obs;

  fetchStages(String workStreamId) async {
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .get()
        .then((value) {
      if (value.data()!.containsKey("verifiedStage")) {
        isVerified.value = value.data()!['verifiedStage'];
      } else {
        isVerified.value = false;
      }
    });

    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .orderBy("createdAt", descending: false)
        .get()
        .then((value) {
      print("Here length: ${value.docs.length}");
      for (int i = 0; i < value.docs.length; i++) {
        stageList.add(StageModel.fromJson(value.docs[i].data()));
        if (value.docs[i].data().containsKey("approveStage")) {
          if (value.docs[i].data()['approveStage']) {
            isApproved.add(value.docs[i].data()['approveStage']);
            feedBackList.add("");
          } else {
            isApproved.add(false);
            feedBackList.add(value.docs[i].data()['feedBack']);
          }
        }
      }
      print("Feedback");
      for (int i = 0; i < feedBackList.length; i++) {
        print(feedBackList[i]);
      }
    });
  }
}
