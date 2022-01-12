// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/auth_controller.dart';

class AuthScreen extends GetWidget<AuthController> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController reEnterPassword = TextEditingController();

  final authController = Get.put(AuthController());

  final String title;

  AuthScreen({required this.title});
  @override
  Widget build(BuildContext context) {
    print("_______________________");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        // ignore: prefer_const_constructors
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontSize: 36),
        ),
        leading: Container(),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/auth_bg.jfif'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.height / 44),
          child: Center(
            child: ListView(children: [
              Column(children: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  margin: EdgeInsets.all(20),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Form(
                        child: Column(
                          children: [
                            Obx(() => (controller.isLogin.value)
                                ? Container()
                                : controller.resetPass.value
                                    ? Container()
                                    : TextFormField(
                                        autocorrect: false,
                                        keyboardType: TextInputType.phone,
                                        decoration: InputDecoration(
                                          labelText: 'Phone Number',
                                        ),
                                        controller: phoneController,
                                      )),
                            TextFormField(
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              enableSuggestions: false,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                labelText: 'Email Address',
                              ),
                              controller: _emailController,
                            ),
                            Obx(() => controller.resetPass.value
                                ? Container()
                                : TextFormField(
                                    obscureText: controller.isPassVisible.value,
                                    decoration: InputDecoration(
                                      labelText: 'Password',
                                      suffixIcon: InkWell(
                                          onTap: () {
                                            controller
                                                .toggolePasswordVisibility();
                                          },
                                          child: Icon(Icons.visibility)),
                                    ),
                                    controller: _passwordController,
                                  )),
                            Obx(() => controller.isLogin.value
                                ? Container()
                                : controller.resetPass.value
                                    ? Container()
                                    : TextFormField(
                                        obscureText:
                                            controller.isRePassVisible.value,
                                        decoration: InputDecoration(
                                            labelText: 'Re-enter Password',
                                            suffixIcon: InkWell(
                                              child: Icon(Icons.visibility),
                                              onTap: () {
                                                controller
                                                    .toggoleRePasswordVisibility();
                                              },
                                            )),
                                        controller: reEnterPassword,
                                      )),
                            Obx(() => controller.isLogin.value
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          controller.resetPass.value =
                                              !controller.resetPass.value;
                                          controller.isLogin.value = false;
                                        },
                                        child: Text(
                                          'Forgot password?',
                                          style: TextStyle(
                                              color: Theme.of(context)
                                                  .primaryColor,
                                              fontSize: 12),
                                        ),
                                      )
                                    ],
                                  )
                                : Container()),
                            SizedBox(
                              height: 12,
                            ),
                            Obx(
                              () => (controller.isLoading.value)
                                  ? CircularProgressIndicator()
                                  : (controller.isLogin.value)
                                      ? Container(
                                          width: 150,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.login(
                                                  _emailController.text.trim(),
                                                  _passwordController.text
                                                      .trim(),
                                                  title);
                                            },
                                            child: Text(
                                              'Login',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                                primary: Theme.of(context)
                                                    .primaryColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(20)),
                                                )),
                                          ),
                                        )
                                      : controller.resetPass.value
                                          ? Container(
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  controller
                                                      .sendPasswordRequest(
                                                          _emailController
                                                              .text);
                                                },
                                                child: Text(
                                                  'Send Request',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    )),
                                              ),
                                            )
                                          : Container(
                                              width: 150,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  if (phoneController
                                                      .text.isEmpty) {
                                                    Get.snackbar(
                                                        'Please Enter Phone Number',
                                                        '',
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText:
                                                            Colors.white);
                                                    return;
                                                  }
                                                  if (phoneController
                                                          .text.length <
                                                      10) {
                                                    Get.snackbar(
                                                        'Please Enter Valid Phone Number',
                                                        '',
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText:
                                                            Colors.white);
                                                    return;
                                                  }
                                                  if (_passwordController
                                                          .text !=
                                                      reEnterPassword.text) {
                                                    Get.snackbar(
                                                        'Please Enter Same Password',
                                                        '',
                                                        backgroundColor:
                                                            Colors.red,
                                                        colorText:
                                                            Colors.white);
                                                    return;
                                                  }

                                                  controller.createUser(
                                                      _emailController.text
                                                          .trim(),
                                                      _passwordController.text
                                                          .trim(),
                                                      phoneController.text
                                                          .trim(),
                                                      title);
                                                },
                                                child: Text(
                                                  'Sign Up',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Theme.of(context)
                                                        .primaryColor,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  20)),
                                                    )),
                                              ),
                                            ),
                            ),
                            Obx(
                              () => controller.isLoading.value
                                  ? Container()
                                  : controller.resetPass.value
                                      ? Container()
                                      : TextButton(
                                          child: Text(controller.isLogin.value
                                              ? 'Create a new account'
                                              : 'I already have an account'),
                                          style: TextButton.styleFrom(
                                              primary: Theme.of(context)
                                                  .primaryColor),
                                          onPressed: () {
                                            controller.toggleLoginStatus();
                                          },
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
            ]),
          ),
        ),
      ),
    );
  }
}
