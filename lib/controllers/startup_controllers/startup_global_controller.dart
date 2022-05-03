// ignore_for_file: prefer_is_empty, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_filter_controller.dart';
import 'package:startupfunding/global.dart';
import 'package:startupfunding/models/investor_model.dart';
import 'package:startupfunding/models/startup_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class StartupGlobalController extends GetxController {
  final User? user = FirebaseAuth.instance.currentUser;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final isLoading = false.obs;
  StartupModel currentStartup = StartupModel();
  final currentIndex = 0.obs;

  final isVerified = false.obs;
  final isRejected = false.obs;
  final isPending = false.obs;

  final rejectedStartup = false.obs;
  final pendingStartup = false.obs;
  final approvedStartup = false.obs;

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

  String newNotificationToken = "";
  List<String>? notificationTokens;

  final StartupFilterController startupFilterController =
      Get.put(StartupFilterController());

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

      if (startupFilterController.isFilterApplied.value) {
        query = firestore
            .collection("Investors")
            .where("expertise", arrayContains: currentStartup.startupCategory)
            .orderBy("createdAt", descending: true);
      } else {
        query = firestore
            .collection("Investors")
            .orderBy("createdAt", descending: true);
      }

      if (lastUser != null) {
        isLoadingMoreData = true;
        query = query.startAfterDocument(lastUser!);
      }

      query = query.limit(itemLimit);

      if (hasMoreData) {
        await query.get().then((snapshot) {
          print(snapshot.docs.isNotEmpty);
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
              fnTerminate = 1;
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
        isLoading.toggle();
        return;
      }

      if (investersList.length == 0 && fnTerminate == 0 && !hasMoreData) {
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
    print("Startup init scrreen get current user");
    isLoading.toggle();
    await firestore.collection("URL").doc("GanacheUrl").get().then((val) {
      rpcUrl = val.data()!['rpcUrl'];
      wsUrl = val.data()!['wsUrl'];
    });
    await firestore.collection("Startups").doc(user!.uid).get().then((val) {
      currentStartup = StartupModel.fromJson(val.data()!);
      print(val.data()!['Stage']);
      isRejected.value = val['isRejected'];
      isVerified.value = val['isVerified'];

      if (isRejected.value == false && isVerified.value == false) {
        pendingStartup.value = true;
      }
      if (isRejected.value) {
        rejectedStartup.value = true;
      }
      if (isVerified.value) {
        approvedStartup.value = true;
      }
    });

    await FirebaseMessaging.instance.getToken().then((token) {
      newNotificationToken = token!;
    });

    if (currentStartup.notificationTokens == null ||
        currentStartup.notificationTokens == [] ||
        !currentStartup.notificationTokens!.contains(newNotificationToken)) {
      if (currentStartup.notificationTokens == null) {
        notificationTokens = [];
      } else {
        notificationTokens = currentStartup.notificationTokens;
      }

      notificationTokens?.add(newNotificationToken);

      if (newNotificationToken != '') {
        await FirebaseFirestore.instance
            .collection("Startups")
            .doc(user!.uid)
            .update({'notificationTokens': notificationTokens});
      }
    }

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
