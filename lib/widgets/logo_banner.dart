import 'package:flutter/material.dart';

import 'package:stardewpedia/helpers/navigation.dart';
import 'package:stardewpedia/helpers/snackbar.dart';

class LogoBanner extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: () {
        NavigationHelper.navigateToMenu(context);
        SnackBarHelper.showMessage(context, "test");
      },
      child: new Container(
        padding: new EdgeInsets.only(bottom: 24.0),
        child: new Image.asset("assets/stardewvalleybannerwide.png"),
      ),
    );
  }

}