// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  final bool startupReqRecieve;
  String? equity;
  String? amount;
  String? loanAmount;
  String? roi;

  UserCard(
      {required this.imgUrl,
      required this.title,
      required this.startupReqRecieve,
      this.equity,
      this.amount,
      this.loanAmount,
      this.roi});
  @override
  Widget build(BuildContext context) {
    print(startupReqRecieve);
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: startupReqRecieve ? 150 : 80,
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundImage: CachedNetworkImageProvider(imgUrl),
                backgroundColor: Colors.grey,
              ),
              title: Text(
                title,
                style: TextStyle(
                  fontFamily: "Cabin",
                  fontSize: 20,
                ),
              ),
              subtitle: !startupReqRecieve
                  ? Container()
                  : (equity == "" && amount == "") ||
                          (equity == null && amount == null)
                      ? Container()
                      : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Equity Stack : " + equity!,
                                  style: TextStyle(
                                    fontFamily: "Cabin",
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                
                                Text(
                                  "Amount: " + amount!,
                                  style: TextStyle(
                                    fontFamily: "Cabin",
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            loanAmount == null || loanAmount == ""
                                ? Container()
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Text(
                                          "Loan amount : " + loanAmount!,
                                          maxLines: 2,
                                          style: TextStyle(
                                            fontFamily: "Cabin",
                                            fontSize: 16,
                                          ),
                                        ),
                                    ),
                                  ],
                                ),
                            roi == null || roi == ""
                                ? Container()
                                : Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                        "ROI : " + roi!,
                                        style: TextStyle(
                                          fontFamily: "Cabin",
                                          fontSize: 16,
                                        ),
                                      ),
                                  ],
                                ),
                          ],
                        ),
              trailing: TextButton(
                  child: Icon(
                    Icons.arrow_right,
                    color: Theme.of(context).primaryColor,
                    size: 30,
                  ),
                  onPressed: () {}),
            ),
          ),
        ),
      ),
    );
  }
}
