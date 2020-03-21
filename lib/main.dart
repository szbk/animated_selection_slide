import 'package:flutter/material.dart';
import 'package:inbox_mail/view/inbox_animation.dart';

void main() => runApp(MainApp());

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'App',
      home: InboxAnimation(),
    );
  }
}
