import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:developer';
import 'package:flutter/material.dart';

import 'package:stardewpedia/helpers/wiki.dart';
import 'package:stardewpedia/widgets/calendar.dart';
import 'package:stardewpedia/widgets/collapsible.dart';
import 'package:stardewpedia/widgets/informed_widget.dart';
import 'package:stardewpedia/widgets/logo_banner.dart';
import 'package:stardewpedia/widgets/season_label.dart';
import 'package:stardewpedia/widgets/section_title.dart';
import 'package:stardewpedia/stardew/seasons.dart';

class SeasonScreen extends StatefulWidget {

  static String routeFor(Seasons season) {
    return "/season/${NameOfSeason(season)}";
  }

  SeasonScreen({Key key, this.season}) : super(key: key);

  final Seasons season;

  @override
  SeasonScreenState createState() => new SeasonScreenState(season: season);
}

class SeasonScreenState extends State<SeasonScreen> {

  SeasonScreenState({ this.season }) : children = [], super() {
    title = NameOfSeason(season);

    fetch();
  }

  Seasons season;

  String title;

  String pageData = "";

  final List<Collapsible> children;

  void fetch() {
    WikiHelper.fetchPage(language: "en", pageName: NameOfSeason(season), params: null).then(onPageLoad);
  }

  void onPageLoad(WikiPage page) {
    if (page == null) {
      throw new ArgumentError.notNull("page");
    }

    WikiPageSection rootSection = page.rootSection;
    WikiPageSection eventSection = rootSection.childMap['events'];
    WikiPageSection cropSection = rootSection.childMap['crops'];
    WikiPageSection forageSection = rootSection.childMap['forage'];
    WikiPageSection fishSection = rootSection.childMap['fish'];

    setState(() {
      children.clear();

      title = page.displayTitle;

      if (eventSection != null) {
        children.add(new Collapsible(
          color: new Color(0xFF0377A0),
          collapsedByDefault: false,
          header: new CollapsibleSectionTitle(
            iconSource: "assets/icons/calendar_event.gif",
            title: eventSection.line,
          ),
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(8.0),
              color: Colors.lightGreen,
              child: new Calendar(
                season: widget.season,
              ),
            ),
          ],
        ));
      }

      if (cropSection != null) {
        children.add(new Collapsible(
          color: new Color(0xFF0377A0),
          collapsedByDefault: false,
          header: new CollapsibleSectionTitle(
            iconSource: "assets/icons/crops.png",
            title: cropSection.line,
          ),
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(8.0),
              color: Colors.lightGreen,
              child: new Calendar(
                season: widget.season,
              ),
            ),
          ],
        ));
      }

      if (forageSection != null) {
        children.add(new Collapsible(
          color: new Color(0xFF0377A0),
          collapsedByDefault: false,
          header: new CollapsibleSectionTitle(
            iconSource: "assets/icons/foraging.png",
            title: forageSection.line,
          ),
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(8.0),
              color: Colors.lightGreen,
              child: new Calendar(
                season: widget.season,
              ),
            ),
          ],
        ));
      }

      if (fishSection != null) {
        children.add(new Collapsible(
          color: new Color(0xFF0377A0),
          collapsedByDefault: false,
          header: new CollapsibleSectionTitle(
            iconSource: "assets/icons/fish.png",
            title: fishSection.line,
          ),
          children: <Widget>[
            new Container(
              padding: new EdgeInsets.all(8.0),
              color: Colors.lightGreen,
              child: new Calendar(
                season: widget.season,
              ),
            ),
          ],
        ));
      }
    });
  }

  void setSeasonBefore() {
    setState(() {
      season = SeasonBefore(season);
    });
  }

  void setSeasonAfter() {
    setState(() {
      season = SeasonAfter(season);
    });
  }

  @override
  Widget build(BuildContext context) {
    var seasonBefore = SeasonBefore(season);
    var seasonAfter = SeasonAfter(season);

    return new Scaffold(
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/stardewbackground.png"),
              fit: BoxFit.cover
          ),
        ),
        child: new Padding(
          padding: new EdgeInsets.only(
            top: 8.0,
            left: 8.0,
            right: 8.0,
          ),
          child: new Center(
            child: new ListView(
              children: <Widget>[
                new LogoBanner(),
                new Container(
                  margin: const EdgeInsets.all(4.0),
                  color: new Color.fromRGBO(255, 255, 255, 0.15),
                  padding: new EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                  child: new Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      new GestureDetector(
                        child: new InformedWidget(
                          child: new SeasonLabel(season: seasonBefore),
                          label: new Padding(
                            padding: new EdgeInsets.only(bottom: 4.0),
                            child: new Text("Preceeded by",
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: setSeasonBefore,
                      ),
                      new GestureDetector(
                        child: new InformedWidget(
                          child: new SeasonLabel(season: seasonAfter),
                          label: new Padding(
                            padding: new EdgeInsets.only(bottom: 4.0),
                            child: new Text("Followed by",
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        onTap: setSeasonAfter,
                      ),
                    ],
                  ),
                ),
                new Container(
                  margin: const EdgeInsets.all(4.0),
                  padding: new EdgeInsets.all(16.0),
                  color: ColorOfSeason(season),
                  child: new SectionTitle(
                    iconSource: "assets/icons/season_${NameOfSeason(season).toLowerCase()}.png",
                    title: NameOfSeason(season),
                  ),
                ),
              ]..addAll(children)..toList(),
            ),
          ),
        ),
      ),
    );
  }
}