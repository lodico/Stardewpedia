import 'package:flutter/material.dart';
import 'package:quiver/collection.dart';

import 'snackbar.dart';

class RouteInfo {

  RouteInfo({ this.baseRoute, this.paramNames });

  final String baseRoute;

  final List<String> paramNames;

}

class RouteParams extends DelegatingMap<String, String> {

  RouteParams(this._delegate);

  final Map<String, String> _delegate;

  @override
  Map<String, String> get delegate => _delegate;

}

typedef ParamWidgetBuilder = WidgetBuilder Function({RouteParams params});

class RouteMap extends DelegatingMap<RouteInfo, ParamWidgetBuilder> {

  static final RegExp paramMatcher = new RegExp(r'^\{([A-z_][A-z0-9_]+)\}$');

  static Map<RouteInfo, ParamWidgetBuilder> parse(Map<String, ParamWidgetBuilder> pseudoDelegate) {
    Map<RouteInfo, ParamWidgetBuilder> delegate = <RouteInfo, ParamWidgetBuilder>{};
    for (var entry in pseudoDelegate.entries) {
      var parts = entry.key.split("/");
      var baseRouteParts = parts.takeWhile((String part) => !paramMatcher.hasMatch(part));
      var baseRoute = baseRouteParts.join("/");
      var paramNames = parts.sublist(baseRouteParts.length).map((String part) => paramMatcher.firstMatch(part).group(1)).toList();
      delegate[new RouteInfo(baseRoute: baseRoute, paramNames: paramNames)] = entry.value;
    }
    return delegate;
  }

  RouteMap(Map<String, ParamWidgetBuilder> pseudoDelegate) :
        _delegate = parse(pseudoDelegate);

  final Map<RouteInfo, ParamWidgetBuilder> _delegate;

  Map<String, RouteInfo> _routes;

  Map<String, RouteInfo> get routes {
    if (_routes == null) {
      _routes = _delegate.map((RouteInfo route, ParamWidgetBuilder pwb) {
        return new MapEntry(route.baseRoute, route);
      });
    }

    return _routes;
  }

  // TODO: implement delegate
  @override
  Map<RouteInfo, ParamWidgetBuilder> get delegate => _delegate;

}

class ParamRoute {

  ParamRoute({ this.params, this.widgetBuilder });

  final RouteParams params;

  final WidgetBuilder widgetBuilder;

}

class NavigationHelper {

  static void tryNavigateTo(BuildContext context, String routeName) {
    try {
      Navigator.pushNamed(context, routeName);
    } catch (exception) {
      SnackBarHelper.showMessage(context, exception.toString());
    }
  }

  static void tryPopTo(BuildContext context, String routeName) {
    Navigator.popUntil(context, (Route<dynamic> route) {
      if (route is ModalRoute<dynamic>) {
        ModalRoute<dynamic> modalRoute = route;
        var name = modalRoute.settings.name;
        return (name == routeName) || (routeName.length > 1 && name.startsWith(routeName));
      }

      return route.isFirst;
    });
  }

  static void navigateToMenu(BuildContext context) {
    Navigator.popUntil(context, (Route<dynamic> route) {
      if (route is ModalRoute<dynamic>) {
        return route.settings.isInitialRoute;
      }

      return route.isFirst;
    });
  }

  static WidgetBuilder findRoute(RouteMap routeMap, String routeName) {
    var parts = routeName.split("/");

    if (routeMap != null && parts.isNotEmpty && 1 < parts.length) {
      var searchParts = <String>[];
      while (searchParts.length < parts.length) {
        searchParts.add(parts[searchParts.length]);
        var searchPath = searchParts.join("/");
        if (routeMap.routes.containsKey(searchPath)) {
          var route = routeMap.routes[searchPath];
          var params = parts.skip(searchParts.length).toList().asMap().map((int index, String paramPart) {
            return new MapEntry(route.paramNames[index], paramPart);
          });
          return routeMap[route](params: new RouteParams(params));
        }
      }
    }

    throw new Exception("No route for '${routeName}'.");
  }

}