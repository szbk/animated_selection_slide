import 'package:flutter/material.dart';
import 'package:inbox_mail/model.dart';
import 'package:flutter/services.dart';
import 'package:inbox_mail/widgets/icon_animation_widget.dart';
import 'widgets/card_tile_widget.dart';
import 'dart:convert';

class InboxAnimation extends StatefulWidget {
  InboxAnimation({Key key}) : super(key: key);
  @override
  _InboxAnimationState createState() => _InboxAnimationState();
}

class _InboxAnimationState extends State<InboxAnimation>
    with SingleTickerProviderStateMixin {
  List<CardMessage> listCardMessage;
  double _headingBarHeight = 65.0;
  double _buttonBarHeight = 45.0;
  double cardHeight = 108;
  List<CardTileWidget> cards;
  List<CardTileWidget> brintToTapCardList;
  double topPosition = 26;
  double iconsTopPositionData;
  // Icon Animation Bool
  bool rightPositionData,
      firstIconAnimationStartData,
      secondIconAnimationStartData,
      thirdIconAnimationStartData;
  // List render
  bool render;
  // Remove index
  int removeIndexData;
  bool removeAnimation = false;

  Future<List<CardMessage>> cardList() async {
    String responseJson = await rootBundle.loadString('assets/data.json');
    List cards = json.decode(responseJson);
    List<CardMessage> listCard =
        cards.map((card) => CardMessage.fromJson(card)).toList();
    return listCard;
  }

  List<CardTileWidget> _list;

  @override
  void initState() {
    super.initState();
    render = false;
    rightPositionData = false;
    firstIconAnimationStartData = false;
    secondIconAnimationStartData = false;
    thirdIconAnimationStartData = false;
    iconsTopPositionData = 0.0;
    getCardList();
  }

  // Card List
  void getCardList() {
    cardList().then(
      (futureResultList) {
        _list = futureResultList.map((card) {
          topPosition = futureResultList.indexOf(card) == 0
              ? topPosition
              : (topPosition + cardHeight);

          return CardTileWidget(
            key: GlobalKey(),
            name: card.name,
            avatar: card.avatar,
            message: card.message,
            time: card.time,
            index: futureResultList.indexOf(card),
            topPosition: topPosition,
            iconsTopPosition: iconsTopPosition,
            height: cardHeight,
            blankCard: false,
            bringToTop: bringToTop,
            rightPosition: rightPosition,
            firstIconPosition: firstIconPosition,
            secondIconPosition: secondIconPosition,
            thirdIconPosition: thirdIconPosition,
            removeIndex: removeItemList,
            removeAnimation: false,
          );
        }).toList();
        // İlk boşluğu ekle
        _list.add(
          CardTileWidget(
            index: (_list.length + 1),
            blankCard: true,
            topPosition: 0,
          ),
        );
        // Son boşluğu ekle
        _list.add(
          CardTileWidget(
            index: (_list.length + 1),
            blankCard: true,
            topPosition:
                (topPosition + _headingBarHeight + _buttonBarHeight - 2),
          ),
        );
        setState(() {});
      },
    );
  }

  void rightPosition(bool data) {
    setState(() {
      rightPositionData = data;
    });
  }

  void firstIconPosition(bool data) {
    setState(() {
      firstIconAnimationStartData = data;
    });
  }

  void secondIconPosition(bool data) {
    setState(() {
      secondIconAnimationStartData = data;
    });
  }

  void thirdIconPosition(bool data) {
    setState(() {
      thirdIconAnimationStartData = data;
    });
  }

  void iconsTopPosition(double data) {
    setState(() {
      iconsTopPositionData = data;
    });
  }

  void bringToTop(CardTileWidget widget) {
    setState(() {
      _list.remove(widget);
      _list.add(widget);
    });
  }

  void removeItemList(int index) {
    if (index != null) {
      double removeItemTopPosition =
          _list.where((item) => item.index == index).toList()[0].topPosition;
      double newTopPosition = topPosition;
      _list.removeWhere((item) => item.index == index);
      _list = _list.map((card) {
        if (card.topPosition < removeItemTopPosition) {
          newTopPosition = card.topPosition;
          removeAnimation = false;
        } else {
          newTopPosition = (card.topPosition - 108.0);
          removeAnimation = true;
        }

        return CardTileWidget(
          key: GlobalKey(),
          name: card.name,
          avatar: card.avatar,
          message: card.message,
          time: card.time,
          index: card.index,
          topPosition: newTopPosition,
          iconsTopPosition: card.iconsTopPosition,
          height: cardHeight,
          blankCard: card.blankCard,
          bringToTop: bringToTop,
          rightPosition: rightPosition,
          firstIconPosition: firstIconPosition,
          secondIconPosition: secondIconPosition,
          thirdIconPosition: thirdIconPosition,
          removeIndex: removeItemList,
          removeAnimation: removeAnimation,
        );
      }).toList();
      setState(() {
        topPosition = (topPosition - 108.0);
        print(topPosition);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _totalHeight =
        (topPosition + _headingBarHeight + _buttonBarHeight + cardHeight + 25);
    return SingleChildScrollView(
      child: _list == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: _totalHeight,
              color: Color(0xffF4F9FF),
              child: Stack(
                children: <Widget>[
                  // Message Text
                  buildHeadingBar(),
                  // Inbox and Archive Button
                  buildButtonBar(),
                  //Person Card List
                  buildCardList(context),
                  // Animation Icons
                  IconAnimation(
                    leftPosition: -27.0,
                    topPosition: iconsTopPositionData,
                    rightAnimationStart: rightPositionData,
                    firstIconAnimationStart: firstIconAnimationStartData,
                    secondIconAnimationStart: secondIconAnimationStartData,
                    thirdIconAnimationStart: thirdIconAnimationStartData,
                  ),
                ],
              ),
            ),
    );
  }

  Container buildCardList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0.0),
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.only(
            top: (_buttonBarHeight + _headingBarHeight - 4),
            left: 0.0,
            right: 0.0),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(children: _list),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBadge() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          '3',
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }

  Positioned buildHeadingBar() {
    return Positioned(
      top: 0.0,
      child: Container(
        height: _headingBarHeight,
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
            buildBadge()
          ],
        ),
      ),
    );
  }

  Positioned buildButtonBar() {
    return Positioned(
      top: _headingBarHeight,
      child: Container(
        color: Colors.white,
        height: _buttonBarHeight,
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.only(left: 15.0, bottom: 0.0),
        child: Row(
          children: <Widget>[
            Container(
              child: Center(
                child: InkWell(
                  onTap: () {
                    setState(() {});
                    _list.forEach((f) => print(!f.blankCard
                        ? f.name + '---' + f.topPosition.toString()
                        : 'blank - ' + f.topPosition.toString()));
                  },
                  child: Text(
                    'Inbox',
                    style: TextStyle(color: Colors.white),
                  ),
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
      ),
    );
  }
}
