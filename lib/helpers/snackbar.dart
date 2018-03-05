import 'package:flutter/material.dart';

class SnackBarHelper {

  static showMessage(BuildContext context, String message) {
    show(context, new Text(message));
  }

  static show(BuildContext context, Widget content) {
    Scaffold.of(context).showSnackBar(new SnackBar(content: content));
  }

}