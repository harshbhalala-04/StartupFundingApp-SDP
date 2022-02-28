// ignore_for_file: prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/models/stage_model.dart';

class VerifyStageController extends GetxController {
  final stage = [].obs;

  final isValidated = [].obs;
  final isApproved = [].obs;
  final isPendingRequest = [].obs;
  final isApprovedRequest = [].obs;

  final isSubmitApplyable = true.obs;

  fetchStages(String workStreamId) async {
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .orderBy("createdAt", descending: false)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        stage.add(StageModel.fromJson(value.docs[i].data()));
        if (value.docs[i].data().containsKey("approveStage")) {
          isValidated.add(true);
          isApproved.add(value.docs[i].data()['approveStage']);
        } else {
          isValidated.add(false);
          isApproved.add(false);
        }

        if (value.docs[i].data().containsKey("pendingRequest")) {
          isPendingRequest.add(value.docs[i].data()['pendingRequest']);
        } else {
          isPendingRequest.add(false);
        }

        if (value.docs[i].data().containsKey("approvedRequest")) {
          isApprovedRequest.add(value.docs[i].data()['approvedRequest']);
        } else {
          isApprovedRequest.add(false);
        }
      }
      if (isValidated.length == 0) {
        isSubmitApplyable.value = false;
      }
    });
  }
}
