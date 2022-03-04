import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/widgets/alert_dialogue.dart';

class UploadProofLinkScreen extends StatefulWidget {
  final String stageUid;
  final String workStreamId;

  UploadProofLinkScreen({required this.stageUid, required this.workStreamId});
  @override
  State<UploadProofLinkScreen> createState() => _UploadProofLinkScreenState();
}

class _UploadProofLinkScreenState extends State<UploadProofLinkScreen> {
  final TextEditingController _proofLinkController = TextEditingController();

  checkData() {
    if (_proofLinkController.text == "") {
      createAlertDialogue("Please enter your proof url.");
    } else {
      Get.back();
      StartupDataBase().addProofUrl(
          _proofLinkController.text, widget.workStreamId, widget.stageUid);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload URL",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 150),
            Container(
              padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Enter URL Here...",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontFamily: "Cabin",
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 7, 20, 0),
              child: Container(
                height: 80,
                child: TextFormField(
                  controller: _proofLinkController,
                  decoration: InputDecoration(
                    // labelText: "Enter URL",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    checkData();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      primary: Theme.of(context).primaryColor),
                  child: Text(
                    "Upload",
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
