import 'package:flutter/material.dart';

class ImplicitAnimation extends StatefulWidget {
  const ImplicitAnimation({Key key}) : super(key: key);

  @override
  _ImplicitAnimationState createState() => _ImplicitAnimationState();
}

class _ImplicitAnimationState extends State<ImplicitAnimation> {
  double currentSize = 60;
  Curve currentCurve = Curves.bounceIn;

  @override
  Widget build(BuildContext context) => _build();

  Widget _build() => _animatedContainer();

  Widget _animatedContainer() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _image(),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 30)),
          Text('select size', textScaleFactor: 1.2),
          _sizeDropdown(),
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 30)),
          Text('select curve', textScaleFactor: 1.2),
          _curveDropdown(),
        ],
      );

  Widget _image() => AnimatedContainer(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: [Colors.amber, Colors.transparent],
          stops: [currentSize > 250 ? 0.2 : 0.5, 1.0],
        )),
        width: currentSize,
        child: Image.asset('images/apple.png'),
        duration: Duration(seconds: 3),
        curve: currentCurve,
      );

  Widget _sizeDropdown() => DropdownButton<double>(
        value: currentSize,
        icon: Icon(Icons.arrow_downward),
        elevation: 1,
        onChanged: (double newSize) => setState(() => currentSize = newSize),
        items: <double>[60, 250, 500].map<DropdownMenuItem<double>>((double value) {
          return DropdownMenuItem<double>(
            value: value,
            child: Text(value.toString()),
          );
        }).toList(),
      );

  Widget _curveDropdown() => DropdownButton<Curve>(
        value: currentCurve,
        icon: Icon(Icons.arrow_downward),
        elevation: 1,
        onChanged: (Curve newValue) => setState(() {
          currentCurve = newValue;
        }),
        items: curves.keys.toList().map<DropdownMenuItem<Curve>>((Curve value) {
          return DropdownMenuItem<Curve>(
            value: value,
            child: Text(curves[value]),
          );
        }).toList(),
      );

  final Map<Curve, String> curves = const {
    Curves.bounceIn: 'bounce in',
    Curves.bounceInOut: 'bounce in out',
    Curves.decelerate: 'decelerate',
    Curves.ease: 'ease',
    Curves.easeInOut: 'ease in out',
    Curves.easeInSine: 'ease in sine',
    Curves.elasticIn: 'elastic in',
    Curves.linear: 'linear',
    Curves.slowMiddle: 'slow middle',
  };
}
