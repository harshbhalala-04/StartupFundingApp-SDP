import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:startupfunding/models/transaction_model.dart';

class ViewFundingController extends GetxController {
  final fundingProvidedStages = [].obs;
  final isLoading = false.obs;
  List<TransactionModel> transactionList = [];
  fetchFundingProvidedStages(String workStreamId) async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("workstream")
        .doc(workStreamId)
        .collection("transactions")
        .orderBy("timestamp", descending: true)
        .get()
        .then((value) {
      for (int i = 0; i < value.docs.length; i++) {
        transactionList.add(TransactionModel.fromJson(value.docs[i].data()));
      }
    });
    isLoading.toggle();
  }
}
