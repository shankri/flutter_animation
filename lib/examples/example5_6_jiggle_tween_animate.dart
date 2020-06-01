import 'package:flutter/material.dart';

///jiggle animation with AnimationController, Tween<double>
///supports: jiggle forever or max jiggles, how fast to jiggle and the rotation start and end
class JiggleTweenAnimate extends StatefulWidget {
  final Widget child;
  final double maxJiggles;
  final int durationInMilliseconds;
  final double beginRotate;
  final double endRotate;

  const JiggleTweenAnimate({
    Key key,
    @required this.child,
    this.maxJiggles: double.infinity,
    this.durationInMilliseconds: 500,
    this.beginRotate: 0.40,
    this.endRotate: -0.40,
  }) : super(key: key);

  @override
  _JiggleTweenAnimateState createState() => _JiggleTweenAnimateState(
        child: child,
        maxJiggles: this.maxJiggles,
        duration: Duration(milliseconds: durationInMilliseconds),
        beginRotate: this.beginRotate,
        endRotate: this.endRotate,
      );
}

class _JiggleTweenAnimateState extends State<JiggleTweenAnimate> with SingleTickerProviderStateMixin {
  final Widget child;
  final Duration duration;
  final double beginRotate;
  final double endRotate;

  AnimationController _controller;
  Animation _animation;
  double maxJiggles; //double.infinity;
  double jiggleCount = 1;

  _JiggleTweenAnimateState({
    this.child,
    this.maxJiggles,
    this.duration,
    this.beginRotate,
    this.endRotate,
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
        begin: this.beginRotate,
        end: this.endRotate,
      ).animate(_controller)
        ..addStatusListener((status) => _handleAnimateStatus(status))
        ..addListener(() => setState(() {
              ///just _animation.value == 0 works fine in android and ios but does not work in web
              if (jiggleCount > maxJiggles /*&& (_animation.value as double).toStringAsPrecision(4) == '0.000'*/) {
                _controller.stop(canceled: true);
              }
            }));

  void _handleAnimateStatus(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
      jiggleCount++;
    }
  }

  @override
  Widget build(BuildContext context) => Transform.rotate(
        angle: _animation.value,
        child: this.child,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
