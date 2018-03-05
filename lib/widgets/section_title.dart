import 'package:flutter/material.dart';
import 'menu_bordered_image.dart';

class SectionTitle extends StatelessWidget {

  SectionTitle({
    Key key,
    this.iconSource,
    this.title,
    this.textAlign: TextAlign.start,
    this.textDirection: TextDirection.ltr,
  }) : super(key: key);

  final String iconSource;

  final String title;

  final TextAlign textAlign;
  final TextDirection textDirection;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    if (iconSource != null && iconSource.trim().length > 0) {
      children.add(new MenuBorderedImage(
          padding: new EdgeInsets.only(right: 16.0),
          image: iconSource,
      ));
    }

    children.add(new Text(
      title,
      textAlign: textAlign,
      textDirection: textDirection,
      style: new TextStyle(
        fontSize: 30.0,
        color: Colors.white,
      ),
    ));

    return new Row(
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }

}
