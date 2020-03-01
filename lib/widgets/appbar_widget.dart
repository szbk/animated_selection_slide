import 'package:flutter/material.dart';

AppBar buildAppBar() {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    leading: IconButton(
      color: Colors.black,
      icon: Icon(Icons.arrow_back),
      onPressed: () {},
    ),
    actions: <Widget>[
      IconButton(
        color: Colors.black,
        icon: Icon(Icons.search),
        onPressed: () {},
      ),
      IconButton(
        color: Colors.black,
        icon: Icon(Icons.more_horiz),
        onPressed: () {},
      ),
    ],
  );
}
