import 'package:flutter/material.dart';
import './card_title_view_model.dart';

class CardTitleView extends CardTitleViewModel {
  @override
  Widget build(BuildContext context) {
    return widget.blankCard
        ? emptyWidget
        : buildPositioned(newPosition, context);
  }

  Widget get emptyWidget => Positioned(
        top: yPosition,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 25,
          color: Colors.white,
        ),
      );

  Positioned buildPositioned(double newPosition, BuildContext context) {
    return Positioned(
      top: widget.removeAnimation ? slideAnimation.value : newPosition,
      left:
          (onePositionEnd ? xAnimation.value : (big100 ? 100 : xPositionOne)) <=
                  100
              ? (onePositionEnd
                  ? xAnimation.value
                  : big100
                      ? (backX ? xBackAnimation.value : xMaxAnimation.value)
                      : xPositionOne)
              : (backX ? xBackAnimation.value : xMaxAnimation.value),
      child: buildOpacity(context),
    );
  }

  Opacity buildOpacity(BuildContext context) {
    return Opacity(
      opacity: opacityAnimation.value,
      child: buildGestureDetector(context),
    );
  }

  GestureDetector buildGestureDetector(BuildContext context) {
    return GestureDetector(
      onPanStart: (details) => onPanStart(details),
      onPanUpdate: (position) => onPanUpdate(position),
      onPanEnd: (details) => onPanEnd(details),
      child: buildCardContainer(context),
    );
  }

  Container buildCardContainer(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.only(left: 10),
      decoration: oneAnimationContinue
          ? BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  spreadRadius: 0.3,
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(3),
                bottomLeft: Radius.circular(3),
              ),
            )
          : BoxDecoration(
              color: Colors.white,
            ),
      child: buildCardColumn(),
    );
  }

  Column buildCardColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(widget.avatar),
          ),
          title: Column(
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    widget.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  Text(
                    widget.time,
                    style: TextStyle(color: Colors.grey, fontSize: 12.0),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
            ],
          ),
          subtitle: Text(
            widget.message,
          ),
          contentPadding:
              EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0, right: 10.0),
        ),
      ],
    );
  }
}
