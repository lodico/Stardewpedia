import 'package:flutter/material.dart';

enum InformationLocation {
  Above,
  Below,
  Start,
  End,
}

class InformedWidget extends StatelessWidget {

  InformedWidget({
    Key key,
    this.child,
    this.label,
    this.labelLocation: InformationLocation.Above,
  }) : assert(child != null), super(key: key);

  final Widget label;

  final InformationLocation labelLocation;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (label == null) {
      return child;
    }

    var children = <Widget>[child];
    switch (labelLocation) {
      case InformationLocation.Above:
      case InformationLocation.Start:
        children.insert(0, label);
        break;

      case InformationLocation.Below:
      case InformationLocation.End:
        children.add(label);
        break;
    }

    switch (labelLocation) {
      case InformationLocation.Above:
      case InformationLocation.Below:
        return new Column(children: children);

      case InformationLocation.Start:
      case InformationLocation.End:
        return new Column(children: children);
    }

    throw new ArgumentError.value(labelLocation);
  }

}
