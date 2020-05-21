import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class CustomAnimationExample extends StatefulWidget {
  _CustomAnimationExampleState createState() => _CustomAnimationExampleState();
}

class _CustomAnimationExampleState extends State<CustomAnimationExample> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  int index = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(seconds: 3), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          this.setState(() => index = index + 1 > 20 ? 0 : index + 1);
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  Widget build(BuildContext context) => CustomAnimatedWidget(
        animationCtrl: _controller,
        index: index,
      );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class CustomAnimatedWidget extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  final Animation<double> _opacityTween;
  final Animation<double> _sizeTween;
  final Animation<double> _finalEffect;
  final Animation<double> _rotateTween;
  final int index;

  CustomAnimatedWidget({Key key, Animation<double> animationCtrl, this.index})
      : _opacityTween = Tween<double>(begin: 0.4, end: 1).animate(CurvedAnimation(
          parent: animationCtrl,
          curve: Interval(0.0, 0.5, curve: Curves.ease),
        )),
        _rotateTween = Tween<double>(begin: 0.4, end: 1.0).animate(CurvedAnimation(
          parent: animationCtrl,
          curve: Interval(0.0, 0.5, curve: Curves.ease),
        )),
        _sizeTween = Tween<double>(begin: 5, end: 250).animate(CurvedAnimation(
          parent: animationCtrl,
          curve: Interval(0.0, 0.700, curve: Curves.ease),
        )),
        _finalEffect = Tween<double>(begin: 250, end: 420).animate(CurvedAnimation(
          parent: animationCtrl,
          curve: Interval(0.800, 1.0, curve: Curves.easeInOutSine),
        )),
        super(
          key: key,
          listenable: animationCtrl,
        );

  Widget build(BuildContext context) {
    timeDilation = 1.5; // 1.0 is normal animation speed.
    return Center(
      child: Opacity(
        opacity: _opacityTween.value,
        child: RotationTransition(
          turns: _rotateTween,
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: _finalEffect.value > 250 ? _finalEffect.value : _sizeTween.value,
            width: _finalEffect.value > 250 ? _finalEffect.value : _sizeTween.value,
            child: Image.asset('icons/${_iconList[index]}'),
          ),
        ),
      ),
    );
  }

  final List<String> _iconList = const [
    'angry.png',
    'in_love.png',
    'rich.png',
    'sad_5.png',
    'surprised_3.png',
    'angry_1.png',
    'in_love_1.png',
    'sad_1.png',
    'sleepy.png',
    'furious.png',
    'in_love_2.png',
    'sad_2.png',
    'smile.png',
    'happy.png',
    'kiss.png',
    'sad_3.png',
    'surprised.png',
    'happy_1.png',
    'kiss_1.png',
    'sad_4.png',
    'surprised_2.png'
  ];
}
