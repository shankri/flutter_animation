import 'package:flutter/material.dart';

class BuiltInExplicitAnimation extends StatefulWidget {
  const BuiltInExplicitAnimation();

  @override
  _BuiltInExplicitAnimationState createState() => _BuiltInExplicitAnimationState();
}

class _BuiltInExplicitAnimationState extends State<BuiltInExplicitAnimation> with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(seconds: 7),
      vsync: this,
    )
      ..addStatusListener((status) => _handleAnimateStatus(status))
      ..forward();
  }

  void _handleAnimateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) => ScaleTransition(
        scale: Tween<double>(begin: 0.3, end: 1).animate(_controller),
        alignment: Alignment.center,
        child: RotationTransition(
          child: Image.asset('images/chakra.png'),
          alignment: Alignment.center,
          turns: _controller,
        ),
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
