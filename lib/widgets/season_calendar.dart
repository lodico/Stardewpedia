import 'package:flutter/material.dart';

import 'package:stardewpedia/helpers/navigation.dart';
import 'package:stardewpedia/stardew/seasons.dart';

import 'calendar.dart';
import 'menu_bordered_image.dart';

typedef SeasonTapCallback = void Function(Seasons season);

typedef PersonTapCallback = void Function();

typedef EventTapCallback = void Function();

class SeasonCalendar extends StatelessWidget {
  SeasonCalendar({ Key key, this.season, this.onTapSeason, this.onTapDay }) : super(key: key);

  final GestureTapCallback onTapSeason;

  final GestureTapCallback onTapDay;

  final Seasons season;

  @override
  Widget build(BuildContext context) {
    final String seasonName = NameOfSeason(season).toLowerCase();

    return new Container(
//      margin: new EdgeInsets.only(
//        bottom: 16.0,
//      ),
      //padding: new EdgeInsets.all(10.0),
      decoration: new BoxDecoration(
        color: Colors.lightGreen,
      ),
      child: new Column(
        children: [
          new Container(
            padding: new EdgeInsets.all(
              8.0,
            ),
            decoration: new BoxDecoration(
              color: Colors.green,
            ),
            child: new GestureDetector(
              onTap: () => NavigationHelper.tryNavigateTo(context, "/season/${seasonName}"),
              child: new Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  new MenuBorderedImage(
                    padding: new EdgeInsets.only(right: 12.0),
                    image: "assets/icons/season_${seasonName}.png",
                    scale: 0.5,
                  ),
                  new Text(
                    NameOfSeason(season),
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          new Container(
            padding: new EdgeInsets.all(
              8.0,
            ),
            child: new Calendar(
              season: season
            ),
          ),
        ],
      ),
    );
  }

}
