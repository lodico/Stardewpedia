import 'package:flutter/material.dart';
import 'package:stardewpedia/stardew/seasons.dart';
import 'icon_label.dart';

class SeasonLabel extends IconLabel {

  SeasonLabel({
    Key key,
    this.season,
    TextStyle textStyle,
  }) : super(key: key,
    icon: new Image.asset('assets/icons/season_${NameOfSeason(season).toLowerCase()}.png'),
    text: NameOfSeason(season),
    textStyle: textStyle,
  );

  final Seasons season;

}
