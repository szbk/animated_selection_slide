import 'package:flutter/material.dart';
import 'package:inbox_mail/model.dart';
import 'package:flutter/services.dart';
import 'package:inbox_mail/widgets/icon_animation_widget.dart';
import 'widgets/card_tile_widget.dart';
import 'dart:convert';

class SlidingListAction extends StatefulWidget {
  final Function updateMessageLength, selectedState;
  SlidingListAction({this.updateMessageLength, this.selectedState});
  @override
  _SlidingListActionState createState() => _SlidingListActionState();
}

class _SlidingListActionState extends State<SlidingListAction>
    with SingleTickerProviderStateMixin {
  List<CardMessage> listCardMessage;
  double _headingBarHeight = 4.0;
  double _buttonBarHeight = 0.0;
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
  Map selectState = {};

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
            id: card.id,
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
            selectedState: selectedState,
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
            topPosition: (topPosition + 108),
          ),
        );
        widget.updateMessageLength((_list.length - 2));
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

  void selectedState(Map val) {
    setState(() {
      selectState = val;
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

        if ((card.blankCard) && (newTopPosition != 0)) {
          if (newTopPosition < (MediaQuery.of(context).size.height - 190)) {
            return CardTileWidget(
              key: GlobalKey(),
              id: card.id,
              name: card.name,
              avatar: card.avatar,
              message: card.message,
              time: card.time,
              index: card.index,
              topPosition: 0,
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
              selectedState: selectedState,
            );
          }
        }

        return CardTileWidget(
          key: GlobalKey(),
          id: card.id,
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
          selectedState: selectedState,
        );
      }).toList();
      widget.updateMessageLength((_list.length - 2));
      widget.selectedState(selectState);
      setState(() {
        topPosition = (topPosition - 108.0);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double _totalHeight =
        (topPosition + _headingBarHeight + _buttonBarHeight + cardHeight + 25);
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: _list == null
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: _totalHeight < (MediaQuery.of(context).size.height - 190)
                  ? (MediaQuery.of(context).size.height - 190)
                  : _totalHeight,
              color: Color(0xffF4F9FF),
              child: Stack(
                children: <Widget>[
                  //Person Card List
                  buildCardList(context),
                  // Animation Icons
                  IconAnimation(
                    leftPosition: -27.0,
                    topPosition: (iconsTopPositionData - 108.0),
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
          top: 0,
          left: 0.0,
          right: 0.0,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: _list.length == 2
                      ? [
                          CardTileWidget(
                            index: 0,
                            blankCard: true,
                            topPosition: 0,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              'No Item',
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          )
                        ]
                      : _list,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
