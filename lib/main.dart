import 'package:flutter/material.dart';
import 'widgets/appbar_widget.dart';
import 'inbox_animation.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App',
        home: Scaffold(
          appBar: buildAppBar(),
          body: MainApp(),
        ),
      ),
    );

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  // Bubble length state management
  int messageLength;
  String selectId;
  int selectAction;

  void updateBubble(int val) {
    setState(() {
      messageLength = val;
    });
  }

  // returns list id and action index
  void selecetedState(Map val) {
    setState(() {
      selectId = val["list_id"];
      selectAction = val["select_action"];
    });
    String _action;
    if (selectAction == 1) {
      _action = 'favorites';
    }else if(selectAction == 2){
       _action = 'delete';
    }else if (selectAction == 3){
      _action = 'archive';
    }
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Selected action \"$_action\" for $selectId id number!'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // print(selectId.toLowerCase() + ' --- ' + selectAction.toString());
    return SafeArea(
      child: Column(
        children: <Widget>[
          // Message Text
          buildHeadingBar(context),
          // Inbox and Archive Button
          buildButtonBar(context),
          Expanded(
            child: SlidingListAction(
              selectedState: selecetedState,
              updateMessageLength: updateBubble,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBadge(int length) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          length.toString(),
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }

  Container buildHeadingBar(BuildContext context) {
    return Container(
      height: 65.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0, bottom: 20.0),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Messages',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          buildBadge(messageLength)
        ],
      ),
    );
  }

  Container buildButtonBar(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Inbox',
                style: TextStyle(color: Colors.white),
              ),
            ),
            width: 80.0,
            height: 32.0,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(color: Colors.blue.withOpacity(0.7), blurRadius: 4.0)
            ], color: Colors.blue, borderRadius: BorderRadius.circular(20.0)),
          ),
          SizedBox(width: 12.0),
          Text(
            'Archive',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
