import 'package:flutter/material.dart';

import 'package:stardewpedia/helpers/navigation.dart';
import 'package:stardewpedia/stardew/seasons.dart';

import 'menu_bordered_image.dart';

typedef SeasonTapCallback = void Function(Seasons season);

typedef PersonTapCallback = void Function();

typedef EventTapCallback = void Function();

class Calendar extends StatelessWidget {
  Calendar({ Key key, this.season, this.onTapSeason, this.onTapDay }) : super(key: key);

  final GestureTapCallback onTapSeason;

  final GestureTapCallback onTapDay;

  final Seasons season;

  @override
  Widget build(BuildContext context) {
    final String seasonName = NameOfSeason(season).toLowerCase();

    return new GestureDetector(
      child: new Image.asset(
          "assets/calendars/${seasonName}.png"
      ),
    );
  }

}
