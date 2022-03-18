import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/models/stage_model.dart';

class VerifySubmittedStageController extends GetxController {
  List<dynamic> photosList = [];
  String document = "";
  String url = "";
  String video = "";
  final isLoading = false.obs;
  List<StageModel> stageList = [];
  final fetchDocLoading = false.obs;

  final pendingStageStatus = [].obs;
  final rejectStageStatus = [].obs;
  final approveStageStatus = [].obs;

  fetchUploadedDocuments(String workStreamId, String stageId) async {
    fetchDocLoading.toggle();

    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .doc(stageId)
        .get()
        .then((val) {
      if (val.data()!['uploadedProofImg']) {
        photosList = val.data()!['proof_of_work']['photos'];
      }
      if (val.data()!['uploadedProofDoc']) {
        document = val.data()!['proof_of_work']['document'];
      }
      if (val.data()!['uploadedProofVideo']) {
        video = val.data()!['proof_of_work']['video'];
      }
      if (val.data()!['uploadedProofUrl']) {
        url = val.data()!['proof_of_work']['url'];
      }

      print(photosList);
      print(document);
      print(video);
      print(url);
    });
    fetchDocLoading.toggle();
  }

  fetchAllStages(String workStreamId) async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("stages")
        .where("submitStageProof", isEqualTo: true)
        .get()
        .then((val) {
      for (int i = 0; i < val.docs.length; i++) {
        stageList.add(StageModel.fromJson(val.docs[i].data()));
        if (val.docs[i].data()['verificationPending']) {
          pendingStageStatus.add(true);
        } else {
          pendingStageStatus.add(false);
        }
        if (val.docs[i].data()['verificationApproved']) {
          approveStageStatus.add(true);
        } else {
          approveStageStatus.add(false);
        }
        if (val.docs[i].data()['verificationRejected']) {
          rejectStageStatus.add(true);
        } else {
          rejectStageStatus.add(false);
        }
      }
    });
    isLoading.toggle();
  }
}


