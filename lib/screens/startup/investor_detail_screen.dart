// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_global_controller.dart';
import 'package:startupfunding/controllers/startup_controllers/startup_request_controller.dart';
import 'package:startupfunding/database/startup_database.dart';
import 'package:startupfunding/models/investor_model.dart';
import 'package:startupfunding/widgets/confirm_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';

class InvestorDetailScreen extends StatefulWidget {
  InvestorModel? investor;
  final bool fromReq;
  String? uid;

  InvestorDetailScreen({this.investor, required this.fromReq, this.uid});

  @override
  _InvestorDetailScreenState createState() => _InvestorDetailScreenState();
}

class _InvestorDetailScreenState extends State<InvestorDetailScreen> {
  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  bool isLoading = false;

  fetchInvestorDetails(String uid) async {
    setState(() {
      isLoading = true;
    });
    await FirebaseFirestore.instance
        .collection("Investors")
        .doc(uid)
        .get()
        .then((val) {
      widget.investor = InvestorModel.fromJson(val.data()!);
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.fromReq) {
      fetchInvestorDetails(widget.uid!);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          "Investor Profile",
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontFamily: "Cabin",
              fontSize: 20),
        ),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        radius: 75.0,
                        backgroundImage: CachedNetworkImageProvider(
                          widget.investor!.investorImg!,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        "${widget.investor!.firstName} ${widget.investor!.lastName}",
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Cabin",
                          fontSize: 20,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text("CEO of XYZ",
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Cabin",
                            fontSize: 18,
                          )),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: Text(widget.investor!.cityName!,
                          style: TextStyle(
                            color: Colors.grey,
                            fontFamily: "Cabin",
                            fontSize: 18,
                          )),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Divider(
                            indent: 30.0,
                            endIndent: 10.0,
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _launchURL(widget.investor!.linkedinUrl!);
                          },
                          child: Image(
                            image: AssetImage("assets/linkedin-color.png"),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            indent: 10.0,
                            endIndent: 30.0,
                            thickness: 1,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (widget.fromReq) {
                              final StartupRequestController
                                  startupRequestController =
                                  Get.put(StartupRequestController());
                              // 1. Remove from pending list
                              startupRequestController.removeRecievedInvestor(
                                  widget.investor!.uid!);

                              // 2. Back to pending page
                              Get.back();

                              // 3. Remove from database
                              StartupDataBase().removeInvestorFromPending(
                                  widget.investor!.uid!);
                            } else {
                              Get.find<StartupGlobalController>()
                                  .removeInvestorFromFeed(
                                      widget.investor!.uid!);
                              Get.back();
                              StartupDataBase().addInvestorToExcludeList(
                                  widget.investor!.uid!, false);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Text(
                              widget.fromReq ? "Reject" : "Skip",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "Cabin",
                                  fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              primary: Colors.white),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (widget.fromReq) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ConfirmDialogue(
                                    userType: "Startup",
                                    investorUid: widget.investor!.uid!,
                                    investorFname: widget.investor!.firstName!,
                                    investorLname: widget.investor!.lastName!,
                                    investorImg: widget.investor!.investorImg!,
                                  );
                                },
                              );
                            } else {
                              Get.find<StartupGlobalController>()
                                  .removeInvestorFromFeed(
                                      widget.investor!.uid!);
                              Get.back();
                              Timestamp time = Timestamp.now();
                              Get.find<StartupRequestController>()
                                  .inviteSentList
                                  .add({
                                "sent": widget.investor!.firstName! +
                                    " " +
                                    widget.investor!.lastName!,
                                "id": widget.investor!.uid,
                                "image": widget.investor!.investorImg,
                                "time": time,
                              });
                              Get.find<StartupRequestController>()
                                  .inviteSentList
                                  .sort(
                                      (a, b) => b["time"].compareTo(a["time"]));
                              StartupDataBase().addInvestorToExcludeList(
                                  widget.investor!.uid!, true);
                              StartupDataBase().addInviteMethod(
                                  Get.find<StartupGlobalController>()
                                      .currentStartup
                                      .startupName!,
                                  Get.find<StartupGlobalController>()
                                      .currentStartup
                                      .startupLogoUrl!,
                                  Get.find<StartupGlobalController>()
                                      .currentStartup
                                      .uid!,
                                  widget.investor!.firstName! +
                                      " " +
                                      widget.investor!.lastName!,
                                  widget.investor!.investorImg!,
                                  widget.investor!.uid!);
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Text(
                              widget.fromReq ? "Accept" : "Invite",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Cabin",
                                  fontSize: 18),
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(40),
                                ),
                              ),
                              primary: Theme.of(context).primaryColor),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "About ${widget.investor!.firstName}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Lorem ipsum dolor sit amet,  consectetur adipiscing elit. Suspendisse placerat pretium ex. Suspendisse vel aliquam tortor. Etiam congue sit amet orci id efficitur. Aliquam at dignissim leo, et bibendum lorem. Morbi dui dui, sollicitudin id enim vitae, dignissim commodo nulla. Aenean tellus purus, accumsan ut ex nec, ornareec.",
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Category ${widget.investor!.firstName} invests in",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                  child: SizedBox(
                                    width: 85,
                                    child: ElevatedButton(
                                      child: Text("C 1"),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: SizedBox(
                                    width: 85,
                                    child: ElevatedButton(
                                      child: Text("C 2"),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 40, 0),
                                  child: SizedBox(
                                    width: 85,
                                    child: ElevatedButton(
                                      child: Text("C 3"),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25)),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(40, 0, 0, 0),
                                  child: SizedBox(
                                    width: 85,
                                    child: ElevatedButton(
                                      child: Text("C 4"),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            Theme.of(context).primaryColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Profession",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // if you need this
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.investor!.category!,
                                  style: TextStyle(fontSize: 18),
                                ),
                                width: 300,
                                height: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Angel Invested Before",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // if you need this
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.investor!.investedBefore!,
                                  style: TextStyle(fontSize: 18),
                                ),
                                width: 300,
                                height: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Investment Preference",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // if you need this
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.investor!.preferInvestment!,
                                  style: TextStyle(fontSize: 18),
                                ),
                                width: 300,
                                height: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Startup Mentorship",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Theme.of(context).primaryColor),
                            ),
                          ),
                          SizedBox(height: 25),
                          Container(
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    20), // if you need this
                                side: BorderSide(
                                  color: Colors.grey.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Container(
                                padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  widget.investor!.mentorStartup!,
                                  style: TextStyle(fontSize: 18),
                                ),
                                width: 300,
                                height: 60,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
    );
  }
}
