import 'package:flutter/material.dart';
import 'package:stardewpedia/helpers/snackbar.dart';
import 'package:stardewpedia/widgets/collapsible.dart';
import 'package:stardewpedia/widgets/season_calendar.dart';
import 'package:stardewpedia/widgets/logo_banner.dart';
import 'package:stardewpedia/widgets/menu_bordered_image.dart';
import 'package:stardewpedia/stardew/seasons.dart';

class Menu extends StatefulWidget {
  Menu({Key key}) : super(key: key);

  @override
  MenuState createState() => new MenuState();
}

class MenuState extends State<Menu> {

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/stardewbackground.png"),
            fit: BoxFit.cover
          ),
        ),
        child: new Padding(
          padding: new EdgeInsets.all(8.0),
          child: new Center(
            child: new ListView(
              children: <Widget>[
                new LogoBanner(),
                new Collapsible(
                  color: new Color(0xFF03A007),
                  header: new CollapsibleSectionTitle(
                    iconSource: "assets/icons/season_all.png",
                    title: "Seasons"
                  ),
                  children: <Widget>[
                    new SeasonCalendar(season: Seasons.Spring),
                    new SeasonCalendar(season: Seasons.Summer),
                    new SeasonCalendar(season: Seasons.Fall),
                    new SeasonCalendar(season: Seasons.Winter),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}