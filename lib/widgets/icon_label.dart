import 'package:flutter/material.dart';
import 'menu_bordered_image.dart';

enum IconLabelAlignment {
  Before,
  After,
}

class IconLabel extends StatelessWidget {

  static final defaultTextStyle = new TextStyle(
    fontSize: 20.0,
    color: Colors.white,
  );

  IconLabel({
    Key key,
    this.icon,
    this.iconAlignment: IconLabelAlignment.Before,

    Padding padding,

    this.text,
    this.textAlign,
    this.textBaseline,
    this.textDirection,
    this.textMaxLines,
    this.textOverflow,
    this.textScaleFactor,
    this.textSoftWrap,

    TextStyle textStyle,

    this.labelAxis: Axis.horizontal,

    this.crossAxisAlignment: CrossAxisAlignment.center,
    this.mainAxisAlignment: MainAxisAlignment.start,
    this.mainAxisSize: MainAxisSize.max,
    this.verticalDirection: VerticalDirection.down,
  }) : assert(icon != null),
        assert(text != null),
        padding = (padding == null ? new Padding(padding: new EdgeInsets.only(left: 8.0)) : padding),
        textStyle = (textStyle == null ? defaultTextStyle : textStyle),
        super(key: key);

  final Image icon;
  final IconLabelAlignment iconAlignment;

  final Padding padding;

  final String text;
  final TextAlign textAlign;
  final TextBaseline textBaseline;
  final TextDirection textDirection;
  final int textMaxLines;
  final TextOverflow textOverflow;
  final double textScaleFactor;
  final bool textSoftWrap;
  final TextStyle textStyle;

  final Axis labelAxis;

  final CrossAxisAlignment crossAxisAlignment;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final VerticalDirection verticalDirection;

  @override
  Widget build(BuildContext context) {
    if (icon == null) {
      throw new ArgumentError.notNull('icon');
    }

    var children = <Widget>[
      new Text(
        text,
        textAlign: textAlign,
        textDirection: textDirection,
        maxLines: textMaxLines,
        overflow: textOverflow,
        textScaleFactor: textScaleFactor,
        softWrap: textSoftWrap,
        style: textStyle,
      ),
    ];

    switch (iconAlignment) {
      case IconLabelAlignment.Before:
        children.insert(0, icon);
        children.insert(1, padding);
        break;

      case IconLabelAlignment.After:
        children.add(padding);
        children.add(icon);
        break;
    }

    if (labelAxis == Axis.vertical) {
      return new Column(
        children: children,
        crossAxisAlignment: crossAxisAlignment,
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        textBaseline: textBaseline,
        verticalDirection: verticalDirection,
      );
    }

    return new Row(
      children: children,
      crossAxisAlignment: crossAxisAlignment,
      mainAxisSize: mainAxisSize,
      mainAxisAlignment: mainAxisAlignment,
      textBaseline: textBaseline,
      verticalDirection: verticalDirection,
    );
  }

}
