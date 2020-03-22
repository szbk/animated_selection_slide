import 'package:flutter/material.dart';
import 'widgets/appbar_widget.dart';
import 'inbox_animation.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: Scaffold(
        appBar: buildAppBar(),
        body: SafeArea(
          child: InboxAnimation(),
        ),
      ),
    );
  }
}
