// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String imgUrl;
  final String title;
  UserCard({required this.imgUrl, required this.title});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CachedNetworkImage(
          imageUrl: imgUrl,
        ),
        title: Text(
          title,
          style: TextStyle(fontFamily: "Cabin", fontSize: 18),
        ),
        trailing: Icon(
          Icons.arrow_right,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
