// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:startupfunding/models/startup_model.dart';
import 'package:url_launcher/url_launcher.dart';

class StartupDetailScreen extends StatelessWidget {
  final StartupModel startup;
  StartupDetailScreen({required this.startup});

  void _launchURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Startup Profile",
          style:
              TextStyle(color: Colors.black, fontFamily: "Cabin", fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image(
              image: CachedNetworkImageProvider(startup.startupLogoUrl!),
              width: MediaQuery.of(context).size.width,
              height: 300,
            ),
            Center(
              child: Text(
                startup.startupName!,
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Icon(
                    Icons.location_on_sharp,
                    color: Colors.black,
                    size: 20,
                  ),
                  Text(
                    startup.startupCity!,
                    style: TextStyle(
                      fontFamily: "Cabin",
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      "Skip",
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
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20.0, vertical: 10),
                    child: Text(
                      "Invite",
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
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Category",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 70,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      startup.startupCategory!,
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment:
                  startup.coFounderImg == "" || startup.coFounderImg == null
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: CachedNetworkImageProvider(
                        startup.founderImg!,
                      ),
                      radius: 50,
                    ),
                    Text(
                      startup.userName!,
                      style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "Founder",
                      style: TextStyle(
                          fontFamily: "Cabin",
                          fontSize: 20,
                          color: Colors.grey),
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL(startup.linkedinUrl!);
                      },
                      child: Image(
                        image: AssetImage("assets/linkedin-color.png"),
                      ),
                    ),
                  ],
                ),
                startup.coFounderImg == "" || startup.coFounderImg == null
                    ? Container()
                    : Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey,
                            backgroundImage: CachedNetworkImageProvider(
                                startup.coFounderImg!),
                            radius: 50,
                          ),
                          Text(
                            startup.secondFounderName!,
                            style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Co-Founder",
                            style: TextStyle(
                                fontFamily: "Cabin",
                                fontSize: 20,
                                color: Colors.grey),
                          ),
                          InkWell(
                            onTap: () {
                              _launchURL(startup.secondFounderLinkedinUrl!);
                            },
                            child: Image(
                              image: AssetImage("assets/linkedin-color.png"),
                            ),
                          ),
                        ],
                      ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "About ${startup.startupName}",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                startup.startupDescription!,
                style: TextStyle(fontFamily: "Cabin", fontSize: 18),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Startup Stage",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                width: MediaQuery.of(context).size.width - 50,
                height: 70,
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      startup.startupStage!,
                      style: TextStyle(
                        fontFamily: "Cabin",
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Pitch Deck",
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.picture_as_pdf,
                color: Theme.of(context).primaryColor,
                size: 30,
              ),
              title: Text(
                "Google Pitch Deck",
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
            SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
