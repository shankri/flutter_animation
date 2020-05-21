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
import 'package:flutter_simple_animation/x-card.dart';

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
        fontFamily: 'Lato',
        canvasColor: Colors.grey[100],
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Color.fromRGBO(105, 121, 126, 1),
          title: Text('Animation Samples', textScaleFactor: 1.2),
          centerTitle: true,
        ),
        body: Scrollbar(
          child: Align(
            alignment: AlignmentDirectional.topCenter,
            child: Container(
              constraints: BoxConstraints(maxWidth: 1600),
              padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
              alignment: Alignment.topCenter,
              child: SingleChildScrollView(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: _examples(context),
                ),
              ),
            ),
          ),
        ),
      )),
    );
  }

  Widget _examples(context) => Wrap(
        spacing: 45,
        runSpacing: 45,
        direction: Axis.horizontal,
        alignment: WrapAlignment.start,
        children: [
          ///example 1
          XCard(
            title: 'Implicit Animation using AnimatedContainer',
            subTitle: 'Widgets: AnimatedContainer, AnimatedOpacity, AnimatedAlign, AnimatedPositioned etc',
            footerInfo: 'Example 1',
            child: ImplicitAnimation(),
          ),

          ///example 2
          XCard(
            title: 'Implicit Animation using TweenAnimation Builder',
            subTitle:
                'Uses Tween<double> and Transform.scale for zoom effect. This animation is on load and not continous please click on referesh icon (top right corner)',
            footerInfo: 'Example 2',
            refresh: () => setState(() {}),
            child: _zoomTweenAnimationBuilderExample2(),
          ),
          //example 3
          XCard(
            title: 'Built in Explicit Animation',
            subTitle: 'ScaleTransition & RotationTransition used with AnimatedController',
            footerInfo: 'Example 3',
            child: BuiltInExplicitAnimation(),
          ),

          ///example 4
          XCard(
            title: 'Explicit Animation',
            subTitle: 'Very similar to Example 2 but uses AnimationController and Tween<double>. Forward, Reverse and Continous effect is acheived through controller',
            footerInfo: 'Example 4',
            child: _zoomTweenAnimationWithControllerExample4(),
          ),
          //example 5
          XCard(
            title: 'Explicit Animation',
            subTitle: 'Use of AnimationController and Tween<double> similar to Example 4.',
            footerInfo: 'Example 5',
            child: _continousJiggleExample5And6(double.infinity),
          ),

          ///example 6
          XCard(
            title: 'Explicit Animation',
            subTitle: 'Use of AnimationController and Tween<double> similar to Example 5. Stops after few jiggles using _controller.stop(canceled: true)',
            footerInfo: 'Example 6',
            child: _continousJiggleExample5And6(1),
            refresh: () => setState(() {}),
          ),

          ///example 7
          XCard(
            title: 'Explicit Animation',
            subTitle: 'Using both Zoom (Example 4) and Jiggle (Example 5) together',
            footerInfo: 'Example 7',
            child: IconsTable(key: Key(DateTime.now().millisecondsSinceEpoch.toString())),
            refresh: () => setState(() {}),
          ),

          ///example 8
          XCard(
            title: 'Explicit Animation with AnimationController',
            subTitle: 'Tween is not used in this example',
            footerInfo: 'Example 8',
            child: Container(child: AppleFallAnimation(), width: 500, height: 300),
          ),

          ///example 9
          XCard(
            title: 'Explicit Animation with AnimationController and Tween',
            subTitle: 'AlignmentTween is used in this example',
            footerInfo: 'Example 9',
            child: Container(child: AppleFallTweenAnimation(), width: 500, height: 300),
          ),

          ///example 10
          XCard(
            title: 'Explicit Animation (custom)',
            subTitle: 'Extending AnimatedWidget + Staggered Animation',
            footerInfo: 'Example 10',
            child: Container(child: CustomAnimationExample(), width: 500, height: 300),
          )
        ],
      );

  Widget _zoomTweenAnimationBuilderExample2() => Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
          ZoomTweenAnimationBuilder(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            child: Image.asset(
              'images/apple.png',
              width: 100,
            ),
          ),
        ],
      );

  Widget _zoomTweenAnimationWithControllerExample4() => SizedBox(
        height: 283,
        child: ZoomTweenAnimate(
          child: Image.asset(
            'images/apple.png',
            width: 100,
          ),
        ),
      );

  Widget _continousJiggleExample5And6(double max) => Column(
        children: [
          JiggleTweenAnimate(
            key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
            maxJiggles: max,
            child: Image.asset(
              'images/apple.png',
              width: 100,
            ),
          ),
        ],
      );
}
