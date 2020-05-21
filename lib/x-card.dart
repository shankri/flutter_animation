import 'package:flutter/material.dart';

class XCard extends StatelessWidget {
  static const double cardWidth = 450;
  static Color backgroundColor = Colors.grey[300];
  static const double titleMinHeight = 175;
  static const double bodyMinHeight = 400;

  final String title;
  final String subTitle;
  final Function refresh;
  final String footerInfo;
  final Widget child;
  const XCard({
    @required this.title,
    @required this.subTitle,
    @required this.footerInfo,
    @required this.child,
    this.refresh,
  });

  @override
  Widget build(BuildContext context) => _xcard();

  Widget _xcard({
    String title,
    String subTitle,
    String footerInfo,
    Widget child,
    Function refresh,
  }) =>
      Container(
        //color: backgroundColor,
        alignment: Alignment.topCenter,
        width: cardWidth,
        child: Card(
          elevation: 5,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_title(), _body(), _footer()],
          ),
        ),
      );

  Widget _title() => Container(
        constraints: BoxConstraints(minHeight: titleMinHeight),
        color: backgroundColor,
        child: ListTile(
          leading: Icon(Icons.forward),
          title: Container(
            child: Text(title, textScaleFactor: 1.15),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
          ),
          subtitle: Container(
            child: Text(subTitle, textScaleFactor: 1.05),
            padding: EdgeInsets.fromLTRB(0, 10, 0, 20),
          ),
          trailing: refresh != null
              ? GestureDetector(
                  child: IconButton(icon: Icon(Icons.refresh), onPressed: null),
                  onTap: refresh,
                )
              : Icon(Icons.check, color: backgroundColor),
        ),
      );

  Widget _body() => Container(
        padding: EdgeInsets.fromLTRB(20, 60, 20, 60),
        width: double.maxFinite,
        child: child,
        constraints: BoxConstraints(minHeight: bodyMinHeight),
      );

  Widget _footer() => Container(
        color: backgroundColor,
        alignment: AlignmentDirectional.center,
        width: double.maxFinite,
        child: Text(footerInfo),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 25),
      );
}
