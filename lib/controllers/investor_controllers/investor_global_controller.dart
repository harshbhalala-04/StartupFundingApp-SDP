// ignore_for_file: avoid_print, prefer_is_empty, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_filter_controller.dart';
import 'package:startupfunding/models/investor_model.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:startupfunding/models/startup_model.dart';

import '../../global.dart';

class InvestorGlobalController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;
  InvestorModel currentInvestor = InvestorModel();

  // Variables
  DocumentSnapshot? lastUser;
  bool isLoadingMoreData = false;
  int itemLimit = 10;
  final hasMoreData = true.obs;
  int currentItemLength = 0;
  int prevItemLength = 0;
  List<StartupModel> startupsList = <StartupModel>[].obs;
  int fnTerminate = 0;
  final endUser = false.obs;
  final AutoScrollController scrollController = AutoScrollController();
  final currentIndex = 0.obs;

  String newNotificationToken = "";
  List<String>? notificationTokens;

  final InvestorFilterController investorFilterController =
      Get.put(InvestorFilterController());

  void removeStartupFromFeed(String uid) {
    startupsList.removeWhere((element) => element.uid == uid);
  }

  void scrollListener() {
    print("Here scroll listener function calls");    
    print(scrollController.offset);
    print(scrollController.position.outOfRange);
    print(scrollController.position.maxScrollExtent);
    if (scrollController.offset >=
            scrollController.position.maxScrollExtent - 100 &&
        !scrollController.position.outOfRange) {
          print("Inside first if condition");
      if (prevItemLength != currentItemLength) {
        print("Here under if condition second time");
        prevItemLength = currentItemLength;
        print("Once again call feed function");
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
            .where("isVerified", isEqualTo: true)
            .where("startupCategory",
                whereIn: investorFilterController.selectedFilters)
            .orderBy("createdAt", descending: true);
      } else {
        query = firestore
            .collection("Startups")
            .where("isVerified", isEqualTo: true)
            .orderBy("createdAt", descending: true);
      }

      if (lastUser != null) {
        isLoadingMoreData = true;
        query = query.startAfterDocument(lastUser!);
      }

      query = query.limit(itemLimit);

      if (hasMoreData.value) {
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
              hasMoreData.value = false;
              fnTerminate = 1;
            }
          } else {
            hasMoreData.value = false;
          }
        });
      }

      startupsList.addAll(tmpUsersList);

      if (startupsList.length < 5 && hasMoreData.value) {
        getStartupsForFeed();
      }

      if (startupsList.length == 0 && fnTerminate == 1 && !hasMoreData.value) {
        endUser.value = true;
        isLoading.toggle();
        return;
      }

      if (startupsList.length == 0 && fnTerminate == 0 && !hasMoreData.value) {
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
    await firestore.collection("URL").doc("GanacheUrl").get().then((val) {
      rpcUrl = val.data()!['rpcUrl'];
      wsUrl = val.data()!['wsUrl'];
    });
    await firestore.collection("Investors").doc(user!.uid).get().then((val) {
      currentInvestor = InvestorModel.fromJson(val.data()!);
    });

    await FirebaseMessaging.instance.getToken().then((token) {
      newNotificationToken = token!;
    });

    if (currentInvestor.notificationTokens == null ||
        currentInvestor.notificationTokens == [] ||
        !currentInvestor.notificationTokens!.contains(newNotificationToken)) {
      if (currentInvestor.notificationTokens == null) {
        notificationTokens = [];
      } else {
        notificationTokens = currentInvestor.notificationTokens;
      }

      notificationTokens?.add(newNotificationToken);

      if (newNotificationToken != '') {
        await FirebaseFirestore.instance
            .collection("Investors")
            .doc(user!.uid)
            .update({'notificationTokens': notificationTokens});
      }
    }

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
