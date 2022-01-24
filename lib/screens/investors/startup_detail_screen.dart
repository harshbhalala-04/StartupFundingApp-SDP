// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class StartupDetailScreen extends StatelessWidget {
  const StartupDetailScreen({Key? key}) : super(key: key);

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
              image: AssetImage("assets/startup.png"),
              width: MediaQuery.of(context).size.width,
              height: 300,
            ),
            Center(
              child: Text(
                "Google",
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
                    "Delhi, India",
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
                      "Software category",
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
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage(
                        "assets/startup.png",
                      ),
                      radius: 50,
                    ),
                    Text(
                      "Sandeep",
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
                    Image(
                      image: AssetImage("assets/linkedin-color.png"),
                    ),
                  ],
                ),
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/startup.png"),
                      radius: 50,
                    ),
                    Text(
                      "Vipul",
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
                    Image(
                      image: AssetImage("assets/linkedin-color.png"),
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
                "About Google",
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
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam sed eleifend velit, quis tristique orci. Ut mollis lacus ac dolor scelerisque consequat. Vivamus faucibus venenatis felis faucibus faucibus. Sed finibus vehicula arcu, vel tristique lorem rhoncus sed. Morbi at magna eu nisi semper finibus vitae eu libero. Aliquam sit amet mi aliquet, rhoncus purus at, eleifend purus. Suspendisse molestie eleifend tincidunt",
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
                      "Beta Launched",
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
              trailing: Icon(Icons.download, size: 30,color: Colors.black,),
            ),
            SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }
}
