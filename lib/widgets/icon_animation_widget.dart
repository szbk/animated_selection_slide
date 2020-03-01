import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_sequence_animation/flutter_sequence_animation.dart';

class IconAnimation extends StatefulWidget {
  final double topPosition, leftPosition;
  final bool rightAnimationStart,
      firstIconAnimationStart,
      secondIconAnimationStart,
      thirdIconAnimationStart;
  IconAnimation(
      {this.topPosition,
      this.leftPosition,
      this.rightAnimationStart,
      this.firstIconAnimationStart,
      this.secondIconAnimationStart,
      this.thirdIconAnimationStart});
  @override
  _IconAnimationState createState() => _IconAnimationState();
}

class _IconAnimationState extends State<IconAnimation>
    with TickerProviderStateMixin {
  AnimationController _sequenceAnimationController,
      _firstIconPositionAnimationController,
      _secondIconPositionAnimationController,
      _thirdIconPositionAnimationController;
  Animation<Offset> _firstIconPosition, _secondIconPosition, _thirdIconPosition;
  SequenceAnimation _sequenceAnimation;
  bool _rightAnimationIsCompleted = false;
  // Total area width and height
  double _iconContainerWidth = 120.0;
  double _iconContainerHeight = 90.0;
  // All icons circle size (width and height)
  double _iconsCircleSize = 25.0;
  // White icon size
  double _whiteIconSize = 17.0;

  @override
  void initState() {
    super.initState();
    // First Animation Controller
    _sequenceAnimationController = AnimationController(vsync: this);
    _sequenceAnimation = SequenceAnimationBuilder()
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 34.0),
            from: Duration.zero,
            to: Duration(milliseconds: 80),
            tag: 'star')
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 34.0),
            from: Duration(milliseconds: 80),
            to: Duration(milliseconds: 200),
            tag: 'trash')
        .addAnimatable(
            animatable: Tween<double>(begin: 0.0, end: 34.0),
            from: Duration(milliseconds: 200),
            to: Duration(milliseconds: 300),
            tag: 'upload')
        .animate(_sequenceAnimationController);
    _sequenceAnimationController.addListener(() {
      setState(() {});
    });
    _sequenceAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _rightAnimationIsCompleted = true;
        });
      }
    });

    // Star Animation
    _firstIconPositionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );

    _firstIconPosition =
        Tween<Offset>(begin: Offset(34.0, 0.0), end: Offset(80.0, 32.0))
            .animate(_firstIconPositionAnimationController)
              ..addListener(() {
                setState(() {});
              });
    // Trash Animation
    _secondIconPositionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );

    _secondIconPosition =
        Tween<Offset>(begin: Offset(34.0, 32.0), end: Offset(80.0, 32.0))
            .animate(_secondIconPositionAnimationController)
              ..addListener(() {
                setState(() {});
              });
    // Upload Animation
    _thirdIconPositionAnimationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 250,
      ),
    );

    _thirdIconPosition =
        Tween<Offset>(begin: Offset(34.0, 64.0), end: Offset(80.0, 32.0))
            .animate(_thirdIconPositionAnimationController)
              ..addListener(() {
                setState(() {});
              });
  }

  @override
  void dispose() {
    _sequenceAnimationController.dispose();
    _firstIconPositionAnimationController.dispose();
    _secondIconPositionAnimationController.dispose();
    _thirdIconPositionAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _firstAnimationValueX = 0.0;
    double _firstAnimationValueY;
    double _secondAnimationValueX;
    double _thirdAnimationValueX;
    double _thirdAnimationValueY = 64.0;

    if (widget.rightAnimationStart) {
      _sequenceAnimationController.forward();
      setState(() {
        _firstAnimationValueX = _sequenceAnimation['star'].value;
        _secondAnimationValueX = _sequenceAnimation['trash'].value;
        _thirdAnimationValueX = _sequenceAnimation['upload'].value;
      });

      // Star Icon Animation
      if (widget.firstIconAnimationStart) {
        setState(() {
          _firstIconPositionAnimationController.forward();
          _firstAnimationValueX = _firstIconPosition.value.dx;
          _firstAnimationValueY = _firstIconPosition.value.dy;
        });
      } else if (_rightAnimationIsCompleted &&
          !widget.firstIconAnimationStart) {
        setState(() {
          _firstIconPositionAnimationController.reverse();
          _firstAnimationValueX = _firstIconPosition.value.dx;
          _firstAnimationValueY = _firstIconPosition.value.dy;
        });
      }

      // Tash Icon Animation
      if (widget.secondIconAnimationStart) {
        setState(() {
          _secondIconPositionAnimationController.forward();
          _secondAnimationValueX = _secondIconPosition.value.dx;
        });
      } else if (_rightAnimationIsCompleted &&
          !widget.secondIconAnimationStart) {
        setState(() {
          _secondIconPositionAnimationController.reverse();
          _secondAnimationValueX = _secondIconPosition.value.dx;
        });
      }
      // Upload Icon Animation
      if (widget.thirdIconAnimationStart) {
        setState(() {
          _thirdIconPositionAnimationController.forward();
          _thirdAnimationValueX = _thirdIconPosition.value.dx;
          _thirdAnimationValueY = _thirdIconPosition.value.dy;
        });
      } else if (_rightAnimationIsCompleted &&
          !widget.thirdIconAnimationStart) {
        setState(() {
          _thirdIconPositionAnimationController.reverse();
          _thirdAnimationValueX = _thirdIconPosition.value.dx;
          _thirdAnimationValueY = _thirdIconPosition.value.dy;
        });
      }
    } else {
      _sequenceAnimationController.reverse();
      _firstIconPositionAnimationController.reset();
      _secondIconPositionAnimationController.reset();
      _thirdIconPositionAnimationController.reset();
      setState(() {
        _rightAnimationIsCompleted = false;
        _firstAnimationValueX = _sequenceAnimation['star'].value;
        _secondAnimationValueX = _sequenceAnimation['trash'].value;
        _thirdAnimationValueX = _sequenceAnimation['upload'].value;
      });
    }

    return Positioned(
      left: widget.leftPosition,
      top: widget.topPosition,
      child: Container(
        width: _iconContainerWidth,
        height: _iconContainerHeight,
        child: Stack(
          children: <Widget>[
            // Solid Circle
            Positioned(
              top: 32.0,
              left: 80.0,
              child: AnimatedOpacity(
                duration: Duration(milliseconds: 100),
                opacity: widget.rightAnimationStart ? 1 : 0,
                child: DottedBorder(
                  color: Colors.grey,
                  padding: EdgeInsets.all(0.0),
                  borderType: BorderType.Circle,
                  child: Container(
                    width: _iconsCircleSize,
                    height: _iconsCircleSize,
                  ),
                ),
              ),
            ),
            // Star
            Positioned(
              top: _firstAnimationValueY,
              left: _firstAnimationValueX,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.2),
                      blurRadius: 2.0,
                      spreadRadius: 1.5,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                width: _iconsCircleSize,
                height: _iconsCircleSize,
                child: Icon(
                  Icons.star,
                  size: _whiteIconSize,
                  color: Colors.white,
                ),
              ),
            ),
            // Trash
            Positioned(
              top: 32.0,
              left: _secondAnimationValueX,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.2),
                      blurRadius: 1.0,
                      spreadRadius: 1.5,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                width: _iconsCircleSize,
                height: _iconsCircleSize,
                child: Icon(
                  Icons.delete_outline,
                  size: _whiteIconSize,
                  color: Colors.white,
                ),
              ),
            ),
            // Upload
            Positioned(
              top: _thirdAnimationValueY,
              left: _thirdAnimationValueX,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff4A4B68),
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff4A4B68).withOpacity(0.2),
                      blurRadius: 2.0,
                      spreadRadius: 1.5,
                      offset: Offset.zero,
                    ),
                  ],
                ),
                width: _iconsCircleSize,
                height: _iconsCircleSize,
                child: Icon(
                  Icons.file_upload,
                  size: _whiteIconSize,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
