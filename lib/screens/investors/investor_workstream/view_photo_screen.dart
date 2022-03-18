// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ViewPhotoScreen extends StatelessWidget {
  final List<dynamic> photos;
  ViewPhotoScreen({required this.photos});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Photos",
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
      body: ListView.builder(
          itemCount: photos.length,
          itemBuilder: (ctx, index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 50),
              child: Image(image: CachedNetworkImageProvider(photos[index], ),),
            );
          }),
    );
  }
}
