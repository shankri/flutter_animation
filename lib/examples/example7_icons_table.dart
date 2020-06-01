import 'package:flutter/material.dart';
import 'example2_zoom_tween_animation_builder.dart';
import 'example5_6_jiggle_tween_animate.dart';

class IconsTable extends StatelessWidget {
  final int numOfCols = 4;
  final int numOfRows = 3;
  final double margin = 20;

  const IconsTable({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double iconHeight = (constraints.biggest.height / numOfRows) - (this.margin * 2);
        double iconWidth = (constraints.biggest.width / numOfCols) - (this.margin * 2);

        return Table(
          defaultColumnWidth: FixedColumnWidth((constraints.biggest.width / numOfCols)),
          defaultVerticalAlignment: TableCellVerticalAlignment.top,
          children: List<TableRow>.generate(
            numOfRows,
            (rowIndex) => TableRow(
              children: List<Widget>.generate(
                  numOfCols,
                  (colIndex) => _icon(
                        iconHeight,
                        iconWidth,
                        rowIndex,
                        colIndex,
                      )),
            ),
          ),
        );
      },
    );
  }

  Widget _icon(iconHeight, iconWidth, rowIndex, colIndex) {
    return JiggleTweenAnimate(
      key: Key(_iconList[(rowIndex * numOfCols) + colIndex] + '_parent'),
      child: ZoomTweenAnimationBuilder(
        zoom: 1.75,
        key: Key(_iconList[(rowIndex * numOfCols) + colIndex]),
        child: Container(
          padding: EdgeInsets.all(margin),
          child: Image.asset(
            'icons/${_iconList[(rowIndex * numOfCols) + colIndex]}',
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
    'smile.png'
  ];
}
