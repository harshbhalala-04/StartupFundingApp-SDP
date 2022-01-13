import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startupfunding/screens/investors/investor_home_screen.dart';
import 'package:startupfunding/screens/investors/investor_onboarding_screen/investor_personal_info_screen.dart';
import 'package:startupfunding/screens/startup/startup_home_screen.dart';
import 'package:startupfunding/screens/startup/startup_onboarding_screen/verify_phone_screen.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;
  Rxn<User> firebaseUser = Rxn<User>();
  final isLoading = false.obs;
  final isLogin = true.obs;
  final userEmailId = ''.obs;
  final loginState = false.obs;
  
  final resetPass = false.obs;
  final isConfirm = false.obs;

  String? get user => firebaseUser.value?.email;

  final isPassVisible = true.obs;
  final isRePassVisible = true.obs;

  @override
  void onInit() {
    print("Here onInit call for bindStream");
    firebaseUser.bindStream(_auth.authStateChanges());
  }

  sendPasswordRequest(email) async {
    await _auth.sendPasswordResetEmail(email: email).then((val) {
      Get.snackbar("Password Reset Email link has been sent", "");
    }).catchError((onError) {
      Get.snackbar("Error in email sent", onError.message);
    });
    resetPass.value = false;
    isLogin.value = true;
  }

  void toggleLoginStatus() {
    isLogin.toggle();
  }

  void toggolePasswordVisibility() {
    isPassVisible.toggle();
  }

  void toggoleRePasswordVisibility() {
    isRePassVisible.toggle();
  }

  void toggoleConfrimSwitch() {
    isConfirm.toggle();
  }

  void createUser(
      String? email, String? password, String? phoneNo, String title) async {
    UserCredential userCredential;
    isLoading.toggle();
    try {
      userCredential = await _auth.createUserWithEmailAndPassword(
          email: email!, password: password!);

      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setBool('answers', false);
      sharedPreferences.setString('title', title);

      if (title == "Startup") {
        await FirebaseFirestore.instance
            .collection('Startups')
            .doc(userCredential.user?.uid)
            .set({
          'email': email,
          'phoneNo': phoneNo,
          'createdAt': Timestamp.now(),
          'uid': userCredential.user!.uid,
        });
        Get.to(VerifyPhoneScreen(phoneNo: phoneNo!));
      } else {
        await FirebaseFirestore.instance
            .collection('Investors')
            .doc(userCredential.user?.uid)
            .set({
          'email': email,
          'phoneNo': phoneNo,
          'createdAt': Timestamp.now(),
          'uid': userCredential.user!.uid,
        });
        Get.to(InvestorPersonalInfoScreen());
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      Get.snackbar("Error Creating account", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
  }

  void login(String? email, String? password, String title) async {
    isLoading.toggle();
    try {
      await _auth.signInWithEmailAndPassword(
          email: email!, password: password!);

      userEmailId.value = email;

      loginState.value = true;

      if (title == "Startup") {
        Get.to(StartupHomeScreen());
      } else {
        Get.to(InvestorHomeScreen());
      }
    } on FirebaseAuthException catch (error) {
      print(error);
      Get.snackbar("Error Logging in ", error.message!,
          snackPosition: SnackPosition.BOTTOM);
    }
    isLoading.toggle();
  }
}

mixin FirebaseUser {}
