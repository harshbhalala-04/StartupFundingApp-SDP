// ignore_for_file: prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:startupfunding/models/investor_model.dart';
import 'package:startupfunding/models/startup_model.dart';

class StartupGlobalController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;
  StartupModel currentStartup = StartupModel();
  final currentIndex = 0.obs;

  DocumentSnapshot? lastUser;
  bool isLoadingMoreData = false;
  int itemLimit = 5;
  bool hasMoreData = true;
  int currentItemLength = 0;
  int prevItemLength = 0;
  List<InvestorModel> investersList = <InvestorModel>[].obs;
  int fnTerminate = 0;
  final endUser = false.obs;
  final AutoScrollController scrollController = AutoScrollController();

  removeInvestorFromFeed(String uid) {
    investersList.removeWhere((element) => element.uid == uid);
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
      if (prevItemLength != currentItemLength) {
        prevItemLength = currentItemLength;
        getInvestorsForFeed();
      }
    }
  }

  getInvestorsForFeed() async {
    isLoading.toggle();
    try {
      final stopWatch = Stopwatch()..start();
      List<InvestorModel> tmpUsersList = <InvestorModel>[];
      Query<Map<String, dynamic>> query;

      query = firestore
          .collection("Investors")
          .orderBy("createdAt", descending: true);

      if (lastUser != null) {
        isLoadingMoreData = true;
        query = query.startAfterDocument(lastUser!);
      }

      query = query.limit(itemLimit);

      if (hasMoreData) {
        await query.get().then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            snapshot.docs.forEach((element) {
              if (currentStartup.excludeInvestor == null ||
                  currentStartup.excludeInvestor!.length == 0 ||
                  !currentStartup.excludeInvestor!
                      .contains(element.data()['uid'])) {
                tmpUsersList.add(InvestorModel.fromJson(element.data()));
              }
            });
            lastUser = snapshot.docs[snapshot.docs.length - 1];

            currentItemLength = currentItemLength + snapshot.docs.length;

            if (snapshot.docs.length < itemLimit) {
              hasMoreData = false;
            }
          } else {
            hasMoreData = false;
          }
        });
      }

      investersList.addAll(tmpUsersList);

      if (investersList.length < 5 && hasMoreData) {
        getInvestorsForFeed();
      }

      if (investersList.length == 0 && fnTerminate == 1 && !hasMoreData) {
        endUser.value = true;
        return;
      }

      if (investersList.length == 0 && fnTerminate == 0 && !hasMoreData) {
        endUser.value = true;
        return;
      }

      isLoadingMoreData = false;
      fnTerminate = 1;
      update();
      stopWatch.stop();
      isLoading.toggle();
    } catch (e) {
      print(e);
    }
  }

  getCurrentUser() async {
    isLoading.toggle();
    await firestore.collection("Startups").doc(user!.uid).get().then((val) {
      currentStartup = StartupModel.fromJson(val.data()!);
      
    });
    isLoading.toggle();
    getInvestorsForFeed();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController.addListener(scrollListener);
    getCurrentUser();

    super.onInit();
  }
}
