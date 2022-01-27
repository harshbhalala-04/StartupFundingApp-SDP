import 'package:flutter/material.dart';
import 'package:startupfunding/widgets/bottom_navigation_button.dart';

class StartupProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
              child: Column(
                children: <Widget>[
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(17), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ImageIcon(
                            AssetImage("assets/view_profile_icon.png"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "View Profile",
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          width: 250,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 25,
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
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(17), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ImageIcon(
                            AssetImage("assets/edit_profile_icon.png"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Edit Profile",
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          width: 250,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 25,
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
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(17), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ImageIcon(
                            AssetImage("assets/view_balance_icon.png"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "View Balance",
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          width: 250,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 25,
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
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(17), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ImageIcon(
                            AssetImage("assets/share_icon.png"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Share startup details",
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          width: 250,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 25,
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
                  Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(17), // if you need this
                      side: BorderSide(
                        color: Colors.grey.withOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: ImageIcon(
                            AssetImage("assets/logout_icon.png"),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Log Out",
                            style: TextStyle(fontSize: 18),
                          ),
                          height: 60,
                          width: 250,
                        ),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Icon(
                              Icons.play_arrow,
                              color: Theme.of(context).primaryColor,
                              size: 25,
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
      padding: const EdgeInsets.fromLTRB(16, 150, 16, 16),
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ElevatedButton(
          child: Text(
            'Continue',
            style: TextStyle(fontFamily: "Cabin", fontSize: 18),
          ),
          onPressed: () {
          
          },
          style: ElevatedButton.styleFrom(
            primary: Theme.of(context).primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
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
