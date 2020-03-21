import 'package:flutter/material.dart';
import 'package:inbox_mail/model/model.dart';
import './card_title_view.dart';

class CardTitle extends StatefulWidget {
  final bool press;
  final String avatar, name, message, time;
  final int index;
  final double topPosition, height;
  final CardMessage list;
  final bool blankCard, removeAnimation;
  final Function bringToTop,
      rightPosition,
      firstIconPosition,
      secondIconPosition,
      thirdIconPosition,
      iconsTopPosition,
      removeIndex;
  final Key key;

  const CardTitle(
      {this.press,
      this.avatar,
      this.name,
      this.message,
      this.time,
      this.index,
      this.topPosition,
      this.height,
      this.list,
      this.blankCard,
      this.removeAnimation,
      this.bringToTop,
      this.rightPosition,
      this.firstIconPosition,
      this.secondIconPosition,
      this.thirdIconPosition,
      this.iconsTopPosition,
      this.removeIndex,
      this.key});

  @override
  CardTitleView createState() => new CardTitleView();
}
