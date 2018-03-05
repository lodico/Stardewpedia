import 'package:flutter/material.dart';
import 'menu_bordered_image.dart';
import 'section_title.dart';

class CollapsibleHeader extends StatelessWidget {

  CollapsibleHeader({ Key key, this.child, this.color = Colors.transparent, this.onTap}) : super(key: key);

  final Color color;

  final GestureTapCallback onTap;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: color,
      child: new GestureDetector(
        onTap: onTap == null ? () => {} : onTap,
        child: child,
      ),
    );
  }

}

class CollapsibleSectionTitle extends CollapsibleHeader {

  CollapsibleSectionTitle({
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
    return new CollapsibleHeader(
      child: new SectionTitle(
        iconSource: iconSource,
        title: title,
        textAlign: textAlign,
        textDirection: textDirection,
      ),
    );
  }

}

class Collapsible extends StatefulWidget {
  Collapsible({Key key, this.color: Colors.white, this.collapsedByDefault: true, this.header, this.children}) : super(key: key);

  final Color color;

  final bool collapsedByDefault;

  final CollapsibleHeader header;

  final List<Widget> children;

  @override
  CollapsibleState createState() => new CollapsibleState(collapsedByDefault);
}

class CollapsibleState extends State<Collapsible> {

  CollapsibleState(this._collapsed) : super();

  Widget get _wrappedChildren => new Column(
    children: widget.children,
  );

  Widget get _drawnChildren => _collapsed ? new Container() : _wrappedChildren;

  bool _collapsed;

  void toggleCollapsed() {
    setState(() {
      _collapsed = !_collapsed;
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Card(
      color: widget.color,
      child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new Container(
              color: Colors.transparent,
              child: new GestureDetector(
                  onTap: toggleCollapsed,
                  child: new Padding(
                    padding: new EdgeInsets.all(16.0),
                    child: widget.header,
                  )
              )
            ),
            _drawnChildren
          ]
      )
    );
  }
}
