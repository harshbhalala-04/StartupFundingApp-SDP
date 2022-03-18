// ignore_for_file: prefer_const_constructors

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewUrlScreen extends StatelessWidget {
  final String url;

  ViewUrlScreen({required this.url});

  void _launchURL() async {
    if (!await launch(url)) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    print(url);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "URL",
          style: TextStyle(
              fontFamily: "Cabin",
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor),
        ),
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: url == ""
          ? Center(child: Image(image: AssetImage("assets/not_found.jpeg")))
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "Proof of work URL",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontFamily: "Cabin",
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  child: TextFormField(
                    style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 14,
                        color: Color.fromRGBO(51, 51, 51, 1)),
                    readOnly: true,
                    initialValue: url,
                    decoration: InputDecoration(
                      // suffixIcon: Icon(Icons.copy),
                      suffix: IconButton(
                        icon: Icon(Icons.copy),
                        onPressed: () async {
                          await FlutterClipboard.copy(url);
                          Get.snackbar("Copied to Clipboard", "",
                              backgroundColor: Colors.grey.shade900,
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white);
                        },
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    _launchURL();
                  },
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      )),
                  child: Text(
                    'Open Link',
                    style: TextStyle(fontFamily: "Cabin", fontSize: 20),
                  ),
                ),
              ],
            ),
    );
  }
}
