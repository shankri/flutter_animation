import 'package:flutter/material.dart';

///jiggle animation with AnimationController, Tween<double>
///supports: jiggle forever or max jiggles, how fast to jiggle and the rotation start and end
class ZoomTweenAnimate extends StatefulWidget {
  final Widget child;
  final int durationInMilliseconds;
  final double zoom;

  const ZoomTweenAnimate({
    Key key,
    @required this.child,
    this.durationInMilliseconds: 3000,
    this.zoom: 2,
  }) : super(key: key);

  @override
  _ZoomTweenAnimateState createState() => _ZoomTweenAnimateState(
        child: child,
        duration: Duration(milliseconds: durationInMilliseconds),
        zoom: this.zoom,
      );
}

class _ZoomTweenAnimateState extends State<ZoomTweenAnimate> with SingleTickerProviderStateMixin {
  final Widget child;
  final Duration duration;
  final double zoom;

  AnimationController _controller;
  Animation _animation;

  _ZoomTweenAnimateState({
    this.child,
    this.duration,
    this.zoom,
  });

  @override
  void initState() {
    super.initState();
    _initController();
    _initAnimation();
    _controller.forward();
  }

  void _initController() => _controller = new AnimationController(
        duration: duration,
        vsync: this,
      )
        ..addListener(() {})
        ..addStatusListener((status) {});

  void _initAnimation() => _animation = Tween<double>(
        begin: this.zoom,
        end: 1,
      ).animate(_controller)
        ..addStatusListener((status) => _handleAnimateStatus(status))
        ..addListener(() => setState(() {}));

  void _handleAnimateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) => Transform.scale(
        scale: _animation.value,
        child: this.child,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
