// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class ViewDocScreen extends StatefulWidget {
  String docUrl;

  ViewDocScreen({required this.docUrl});

  @override
  State<ViewDocScreen> createState() => _ViewDocScreenState();
}

class _ViewDocScreenState extends State<ViewDocScreen> {
  ///Download file into private folder
  Future<File?> downloadFile(String url, String fileName) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final file = File("${appStorage.path}/$fileName");

    try {
      final response = await Dio().get(
        url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            receiveTimeout: 0),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      return null;
    }
  }

  Future openFile({required String url, String? fileName}) async {
    final name = fileName ?? url.split('/').last;
    final file = await downloadFile(url, name);
    if (file == null) return;

    print("path: ${file.path}");
    OpenFile.open(file.path);
  }

  @override
  Widget build(BuildContext context) {
    print("*******************8");
    print(widget.docUrl);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Documents",
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
      body: widget.docUrl == ""
          ? Center(child: Image(image: AssetImage("assets/not_found.jpeg")))
          : InkWell(
              onTap: () {
                Get.snackbar(
                  "Wait",
                  "File Downloading",
                  snackPosition: SnackPosition.BOTTOM,
                  colorText: Theme.of(context).primaryColor,
                );
                openFile(
                  url: widget.docUrl,
                );
              },
              child: ListTile(
                leading: Icon(
                  Icons.picture_as_pdf,
                  color: Theme.of(context).primaryColor,
                  size: 30,
                ),
                title: Text(
                  "Proof of work document",
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: "Cabin",
                    fontSize: 20,
                  ),
                ),
                trailing: Icon(
                  Icons.download,
                  size: 30,
                  color: Colors.black,
                ),
              ),
            ),
    );
  }
}
