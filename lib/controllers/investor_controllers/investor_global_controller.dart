// ignore_for_file: avoid_print, prefer_is_empty, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_filter_controller.dart';
import 'package:startupfunding/models/investor_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:startupfunding/models/startup_model.dart';

class InvestorGlobalController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;
  InvestorModel currentInvestor = InvestorModel();

  // Variables
  DocumentSnapshot? lastUser;
  bool isLoadingMoreData = false;
  int itemLimit = 5;
  bool hasMoreData = true;
  int currentItemLength = 0;
  int prevItemLength = 0;
  List<StartupModel> startupsList = <StartupModel>[].obs;
  int fnTerminate = 0;
  final endUser = false.obs;
  final AutoScrollController scrollController = AutoScrollController();
  final currentIndex = 0.obs;

  final InvestorFilterController investorFilterController =
      Get.put(InvestorFilterController());

  void removeStartupFromFeed(String uid) {
    startupsList.removeWhere((element) => element.uid == uid);
  }

  void scrollListener() {
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
      if (prevItemLength != currentItemLength) {
        prevItemLength = currentItemLength;
        getStartupsForFeed();
      }
    }
  }

  getStartupsForFeed() async {
    isLoading.toggle();
    try {
      final stopWatch = Stopwatch()..start();
      List<StartupModel> tmpUsersList = <StartupModel>[];
      Query<Map<String, dynamic>> query;
     
      if (investorFilterController.isFilterApplied.value) {
        print("Inside filter query");
        query = firestore
            .collection("Startups")
            .where("startupCategory",
                whereIn:
                    investorFilterController.selectedFilters)
            .orderBy("createdAt", descending: true);
      } else {
        query = firestore
            .collection("Startups")
            .orderBy("createdAt", descending: true);
      }

     

      if (lastUser != null) {
        isLoadingMoreData = true;
        query = query.startAfterDocument(lastUser!);
      }

      query = query.limit(itemLimit);

      if (hasMoreData) {
        await query.get().then((snapshot) {
          if (snapshot.docs.isNotEmpty) {
            print("Inside for each loop initialization");
            snapshot.docs.forEach((element) {
              print(element.data());
              if (currentInvestor.excludedStartup == null ||
                  currentInvestor.excludedStartup!.length == 0 ||
                  !currentInvestor.excludedStartup!
                      .contains(element.data()['uid'])) {
                tmpUsersList.add(StartupModel.fromJson(element.data()));
                print(tmpUsersList);
              }
            });
            lastUser = snapshot.docs[snapshot.docs.length - 1];

            currentItemLength = currentItemLength + snapshot.docs.length;

            if (snapshot.docs.length < itemLimit) {
              hasMoreData = false;
              fnTerminate = 1;
            }
          } else {
            hasMoreData = false;
          }
        });
      }

      startupsList.addAll(tmpUsersList);

      if (startupsList.length < 5 && hasMoreData) {
        getStartupsForFeed();
      }

      if (startupsList.length == 0 && fnTerminate == 1 && !hasMoreData) {
        endUser.value = true;
        isLoading.toggle();
        return;
      }

      if (startupsList.length == 0 && fnTerminate == 0 && !hasMoreData) {
        endUser.value = true;
        isLoading.toggle();
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
    await firestore.collection("Investors").doc(user!.uid).get().then((val) {
      currentInvestor = InvestorModel.fromJson(val.data()!);
    });

    isLoading.toggle();
    getStartupsForFeed();
  }

  @override
  void onInit() {
    // TODO: implement onInit
    scrollController.addListener(scrollListener);
    getCurrentUser();

    super.onInit();
  }
}
