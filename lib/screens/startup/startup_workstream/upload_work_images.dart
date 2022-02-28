import 'package:flutter/material.dart';

class UploadWorkImagesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Upload Images",
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
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.fromLTRB(25, 25, 0, 0),
                alignment: Alignment.bottomLeft,
                child: Text(
                  "Upload Your Photos Here...",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontFamily: "Cabin",
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                          shape: CircleBorder(),
                          color: Colors.white,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 37.5, 0, 0),
                                child: Icon(
                                  Icons.add_sharp,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                          shape: CircleBorder(),
                          color: Colors.white,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 37.5, 0, 0),
                                child: Icon(
                                  Icons.add_sharp,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                          shape: CircleBorder(),
                          color: Colors.white,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 37.5, 0, 0),
                                child: Icon(
                                  Icons.add_sharp,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 15),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 150,
                        height: 150,
                        padding: new EdgeInsets.all(10.0),
                        child: Card(
                          shape: CircleBorder(),
                          color: Colors.white,
                          elevation: 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 37.5, 0, 0),
                                child: Icon(
                                  Icons.add_sharp,
                                  size: 40,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 50,
                  width: 250,
                  child: ElevatedButton(
                    onPressed: () {},
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
      ),
    );
  }
}
