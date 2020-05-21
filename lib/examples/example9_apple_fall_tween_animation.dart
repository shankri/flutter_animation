import 'package:flutter/material.dart';

//apple vertically down and up animation
//Use of AnimationController and AlignmentTween
class AppleFallTweenAnimation extends StatefulWidget {
  AppleFallTweenAnimation({Key key}) : super(key: key);

  @override
  _AppleFallTweenAnimationState createState() => _AppleFallTweenAnimationState();
}

class _AppleFallTweenAnimationState extends State<AppleFallTweenAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();
    _initController();
    _initTween();
    _controller.forward();
  }

  void _initController() => _controller = new AnimationController(
        duration: new Duration(seconds: 5),
        vsync: this,
      )
        ..addListener(() => this.setState(() {/*print(_controller.value)*/}))
        ..addStatusListener((status) => _handleAnimateStatus(status));

  void _handleAnimateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  void _initTween() => _animation = AlignmentTween(
        begin: new Alignment(-1.0, -0.8),
        end: new Alignment(1.0, -0.8),
      ).animate(_controller);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          FractionallySizedBox(
            heightFactor: 0.15,
            widthFactor: 0.15,
            alignment: _animation.value,
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
