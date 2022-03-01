import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/models/stage_model.dart';

class CreateEditStageController extends GetxController {
  final RxList<dynamic> stageList = [].obs;
  final isStageSubmitted = false.obs;

  final isApproved = [].obs;
  final feedBackList = [].obs;

  final pendingRequest = [].obs;
  final approvedRequest = [].obs;

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

        if (value.docs[i].data().containsKey("pendingRequest")) {
          pendingRequest.add(value.docs[i].data()['pendingRequest']);
        } else {
          pendingRequest.add(false);
        }

        if (value.docs[i].data().containsKey("approvedRequest")) {
          approvedRequest.add(value.docs[i].data()['approvedRequest']);
        } else {
          approvedRequest.add(false);
        }
      }
    });
  }
}
