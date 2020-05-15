import 'package:flutter/material.dart';

class ZoomTweenAnimationBuilder extends StatelessWidget {
  final Widget child;
  final int durationInMilliseconds;
  final double zoom;

  ZoomTweenAnimationBuilder({
    Key key,
    this.child,
    this.durationInMilliseconds: 3000,
    this.zoom: 2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => TweenAnimationBuilder(
        tween: Tween<double>(begin: zoom, end: 1),
        duration: Duration(milliseconds: durationInMilliseconds),
        builder: (BuildContext context, double zoomLevel, Widget child) => Transform.scale(
          scale: zoomLevel,
          child: this.child,
        ),
      );
}
