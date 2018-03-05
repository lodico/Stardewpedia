import 'package:flutter/material.dart';

class BorderedImage extends StatelessWidget {

  BorderedImage({
    Key key,
    this.padding,
    this.borderImage,
    this.borderFit = BoxFit.fill,
    this.borderSlice,
    this.borderPadding,
    this.image,
    this.scale = 1.0,
  }) : super(key: key);

  final EdgeInsetsGeometry padding;

  final String borderImage;

  final BoxFit borderFit;

  final Rect borderSlice;

  final EdgeInsetsGeometry borderPadding;

  final String image;

  final double scale;

  @override
  Widget build(BuildContext context) {
    return new Container(
      padding: padding,
      child: new Image.asset(
        image,
      ),
//      padding: padding,
//      child: new Container(
//        decoration: new BoxDecoration(
//          image: new DecorationImage(
//            image: new AssetImage(borderImage),
//            fit: BoxFit.contain,
//            centerSlice: borderSlice,
//          ),
//        ),
//        padding: borderPadding,
//        child: new Image.asset(
//          image,
//          color: Colors.white70,
//          scale: 0.5 / scale,
//        ),
//      ),
    );
  }

}
