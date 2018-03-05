import 'package:flutter/material.dart';
import 'bordered_image.dart';

class MenuBorderedImage extends BorderedImage {

  MenuBorderedImage({
    Key key,
    EdgeInsetsGeometry padding,
    String image,
    double scale = 1.0,
  }) : super(
      key: key,
      padding: padding,
      image: image,
      borderPadding: new EdgeInsets.all(15.0),
      borderSlice: new Rect.fromLTWH(15.0, 15.0, 15.0, 15.0),
      borderImage: "assets/ui/menu_border.png",
      scale: scale,
  );

}
