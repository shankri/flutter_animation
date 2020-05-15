import 'package:flutter/material.dart';

//apple vertically down and up animation
//Use of JUST AnimationController and No Tween
//For use of Tween refer: apple_fall_tween_animation.dart
class AppleFallAnimation extends StatefulWidget {
  AppleFallAnimation({Key key}) : super(key: key);

  @override
  _AppleFallAnimationState createState() => _AppleFallAnimationState();
}

class _AppleFallAnimationState extends State<AppleFallAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _initController();
    _controller.forward();
  }

  void _initController() => _controller = new AnimationController(
        duration: new Duration(seconds: 5),
        vsync: this,
        lowerBound: -1.0,
        upperBound: 1.0,
      )
        ..addListener(() {
          this.setState(() {/*print(_controller.value)*/});
        })
        ..addStatusListener((status) => _handleAnimateStatus(status));

  void _handleAnimateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            heightFactor: 0.15,
            widthFactor: 0.15,
            alignment: Alignment(-0.8, _controller.value),
            child: Image.asset(
              'images/apple.png',
              width: 20,
              height: 20,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
