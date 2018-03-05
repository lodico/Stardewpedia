import 'package:flutter/material.dart';

enum Seasons {
  Spring,
  Summer,
  Fall,
  Winter,
}

// ignore: non_constant_identifier_names
final Map<String, Seasons> SeasonsMap = {
  "spring": Seasons.Spring,
  "summer": Seasons.Summer,
  "fall": Seasons.Fall,
  "winter": Seasons.Winter,
};

// ignore: non_constant_identifier_names
final Map<Seasons, String> SeasonsNameMap = {
  Seasons.Spring: "Spring",
  Seasons.Summer: "Summer",
  Seasons.Fall: "Fall",
  Seasons.Winter: "Winter",
};

Seasons SeasonFor(String seasonName) {
  if (seasonName == null || seasonName.isEmpty) {
    throw new ArgumentError.notNull('seasonName');
  }

  var lowercaseSeasonName = seasonName.toLowerCase();
  if (!SeasonsMap.containsKey(lowercaseSeasonName)) {
    throw new ArgumentError.value(lowercaseSeasonName);
  }

  return SeasonsMap[lowercaseSeasonName];
}

String NameOfSeason(Seasons season) {
  if (season == null) {
    throw new ArgumentError.notNull('season');
  }

  return SeasonsNameMap[season];
}

Color ColorOfSeason(Seasons season) {
  switch (season) {
    case Seasons.Spring:
      return new Color.fromRGBO(248, 148, 227, 1.0);

    case Seasons.Summer:
      return new Color.fromRGBO(25, 152, 32, 1.0);

    case Seasons.Fall:
      return new Color.fromRGBO(220, 114, 4, 1.0);

    case Seasons.Winter:
      return new Color.fromRGBO(101, 181, 251, 1.0);
  }

  throw new ArgumentError.value(season);
}

Seasons SeasonBefore(Seasons season) {
  switch (season) {
    case Seasons.Spring:
      return Seasons.Winter;
      
    case Seasons.Summer:
      return Seasons.Spring;
      
    case Seasons.Fall:
      return Seasons.Summer;
      
    case Seasons.Winter:
      return Seasons.Fall;
  }
  
  throw new ArgumentError.value(season);
}

Seasons SeasonAfter(Seasons season) {
  switch (season) {
    case Seasons.Spring:
      return Seasons.Summer;

    case Seasons.Summer:
      return Seasons.Fall;

    case Seasons.Fall:
      return Seasons.Winter;

    case Seasons.Winter:
      return Seasons.Spring;
  }

  throw new ArgumentError.value(season);
}
