import 'package:flutter/material.dart';
import 'package:stardewpedia/helpers/navigation.dart';
import 'package:stardewpedia/routes/menu.dart';
import 'package:stardewpedia/routes/season.dart';
import 'package:stardewpedia/routing/fade_route.dart';
import 'package:stardewpedia/stardew/seasons.dart';

void main() => runApp(new Stardewpedia());

class Stardewpedia extends StatelessWidget {

  RouteMap get routes => new RouteMap(<String, ParamWidgetBuilder>{
    "/": ({RouteParams params}) => (BuildContext context) => new Menu(),
    "/season/{name}": ({RouteParams params}) {
      return (BuildContext context) => new SeasonScreen(season: SeasonFor(params['name']));
    },
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return new MaterialApp(
        title: 'Stardewpedia',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or press Run > Flutter Hot Reload in IntelliJ). Notice that the
          // counter didn't reset back to zero; the application is not restarted.
          primarySwatch: Colors.teal,
        ),
        onGenerateRoute: (RouteSettings settings) {
          var builder = NavigationHelper.findRoute(routes, settings.name);

          if (builder == null) {
            throw new Exception("No route for '${settings.name}'.");
          }

          return new FadeRoute(
            builder: builder,
            settings: settings,
          );
        }
    );
  }
}


