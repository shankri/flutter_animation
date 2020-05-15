import 'package:flutter/material.dart';
import 'package:flutter_simple_animation/examples/example10.dart';
import 'package:flutter_simple_animation/examples/example1_implicit_animation.dart';
import 'package:flutter_simple_animation/examples/example2_zoom_tween_animation_builder.dart';
import 'package:flutter_simple_animation/examples/example3_builtin_explicit_anim.dart';
import 'package:flutter_simple_animation/examples/example4_zoom_tween_animate.dart';
import 'package:flutter_simple_animation/examples/example5_6_jiggle_tween_animate.dart';
import 'package:flutter_simple_animation/examples/example7_icons_table.dart';
import 'package:flutter_simple_animation/examples/example8_apple_fall_animation_ctrl.dart';
import 'package:flutter_simple_animation/examples/example9_apple_fall_tween_animation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple Flutter Animation',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
          child: Scaffold(
        body: Scrollbar(
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: BoxConstraints(maxWidth: 1000),
              width: double.maxFinite,
              padding: EdgeInsets.fromLTRB(5, 20, 5, 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Text('ANIMATION SAMPLES', style: TextStyle(fontSize: Theme.of(context).textTheme.headline5.fontSize)),
                    Padding(padding: EdgeInsets.fromLTRB(5, 10, 5, 10)),

                    _addItem(context, ImplicitAnimation(),
                        'EXAMPLE 1: IMPLICIT Animation \n\nAnimation mostly based on (user) events.\nIn the below example, change curve and size options to see animation. \n\nWidgets: AnimatedContainer, AnimatedOpacity, AnimatedAlign, AnimatedPositioned etc'),
                    //..
                    _addItem(context, _zoomTweenAnimationBuilderExample2(),
                        'EXAMPLE 2: IMPLICIT Animation \n\nTweenAnimationBuilder:  Animation on load of a widget. It is not continous. \nBelow example uses Tween<double> and Transform.scale for zoom effect'),
                    //..
                    _addItem(context, BuiltInExplicitAnimation(),
                        'EXAMPLE 3: Built-In EXPLICIT Animation \n\nScaleTransition & RotationTransition used with AnimatedController'),
                    //..
                    _addItem(context, _zoomTweenAnimationWithControllerExample4(),
                        'EXAMPLE 4: EXPLICIT Animation \n\nVery similar to Example 2 but uses AnimationController and Tween<double>. Forward, Reverse and Continous effect is acheived through controller'),
                    //....
                    _addItem(context, _continousJiggleExample5And6(double.infinity),
                        'EXAMPLE 5: EXPLICIT Animation \n\nUse of AnimationController and Tween<double> just like Example 4. This is continous animation.'),
                    //....
                    _addItem(context, _continousJiggleExample5And6(1),
                        'EXAMPLE 6: EXPLICIT Animation \n\nSame as EXAMPLE 5 but stops after 2 jiggles using _controller.stop(canceled: true)'),
                    //....
                    _addItem(context, _iconTableExample7(), 'EXAMPLE 7: EXPLICIT Animation \n\nUsing both Zoom (Example 4) and Jiggle (Example 5) together'),
                    //....
                    _addItem(context, Container(child: AppleFallAnimation(), width: 500, height: 400, constraints: BoxConstraints(maxWidth: 450)),
                        'EXAMPLE 8: EXPLICIT Animation \n\nAnimationController WITHOUT use of any Tween'),
                    //....
                    _addItem(context, Container(child: AppleFallTweenAnimation(), width: 500, height: 400, constraints: BoxConstraints(maxWidth: 450)),
                        'EXAMPLE 9 \n\nAnimationController with AlignmentTween'),
                    //....
                    _addItem(context, Container(child: CustomAnimationExample(), width: 500, height: 400, constraints: BoxConstraints(maxWidth: 450)),
                        'EXAMPLE 10 \n\nExtending AnimatedWidget + Staggered Animation'),
                  ],
                  //child: ImplicitAnimation(),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _iconTableExample7() => Container(
        constraints: BoxConstraints(minHeight: 200, maxWidth: 450),
        child: Column(
          children: [
            IconsTable(key: Key(DateTime.now().millisecondsSinceEpoch.toString())),
            Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
            RaisedButton(child: Text('Rebuild Widget'), onPressed: () => setState(() {})),
          ],
        ),
      );

  Widget _zoomTweenAnimationBuilderExample2() => Container(
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          children: [
            Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
            ZoomTweenAnimationBuilder(
              key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
              child: Image.asset(
                'images/apple.png',
                width: 100,
              ),
            ),
            Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0)),
            RaisedButton(child: Text('Rebuild Widget'), onPressed: () => setState(() {}))
          ],
        ),
      );

  Widget _zoomTweenAnimationWithControllerExample4() => Container(
        constraints: BoxConstraints(minHeight: 200),
        child: ZoomTweenAnimate(
          child: Image.asset(
            'images/apple.png',
            width: 100,
          ),
        ),
      );

  Widget _continousJiggleExample5And6(double max) => Container(
        constraints: BoxConstraints(minHeight: 200),
        child: Column(
          children: [
            JiggleTweenAnimate(
              key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
              maxJiggles: max,
              child: Image.asset(
                'images/apple.png',
                width: 100,
              ),
            ),
            if (max != double.infinity) Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 0)),
            if (max != double.infinity) RaisedButton(child: Text('Rebuild Widget'), onPressed: () => setState(() {}))
          ],
        ),
      );

  Widget _addItem(context, Widget child, String info) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              color: Colors.grey[800],
            ),
            width: double.maxFinite,
            padding: EdgeInsets.all(10),
            child: Text(info,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: Theme.of(context).textTheme.subtitle1.fontSize,
                  height: 1.8,
                )),
          ),
          Padding(padding: EdgeInsets.fromLTRB(5, 20, 5, 20)),
          child,
          Padding(padding: EdgeInsets.fromLTRB(5, 20, 5, 20)),
        ],
      );
}
