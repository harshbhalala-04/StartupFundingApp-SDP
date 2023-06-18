import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartupDeleteAccScreen extends StatelessWidget {
  @override
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Account !!'),
          content: const Text("Are You Sure You Want To Delete Your Account ?"),
          actions: <Widget>[
            ElevatedButton(
              child: const Text("Cancle"),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: const Text("Delete"),
              onPressed: () {},
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Delete Account",
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontFamily: "Cabin",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 150),
            Container(
              padding: const EdgeInsets.fromLTRB(25, 25, 0, 0),
              alignment: Alignment.bottomLeft,
              child: Text(
                "Enter Your Password ",
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
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    showAlert(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      primary: Theme.of(context).primaryColor),
                  child: const Text(
                    "Delete",
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
