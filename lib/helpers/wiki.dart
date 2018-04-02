import 'dart:async';

import 'http.dart';

T internalWikiValueOrDefault<T>(dynamic value, T defaultValue) => (value == null) ? defaultValue : value;

class WikiPageSection {

  WikiPageSection.parse(Map json, { this.parent }) :
        toclevel = internalWikiValueOrDefault(json["toclevel"], 0),
        line = internalWikiValueOrDefault(json["line"], ""),
        text = internalWikiValueOrDefault(json["text"], "") {
    if (parent != null) {
      parent.children.add(this);
      parent.childMap[line.toLowerCase()] = this;
    }
  }

  WikiPageSection({
    this.toclevel,
    this.line,
    this.text,
    this.parent,
  });

  final int toclevel;

  final WikiPageSection parent;

  final String line;

  final String text;

  final List<WikiPageSection> children = new List<WikiPageSection>();

  final Map<String, WikiPageSection> childMap = {};

  bool get hasChildren => children.isNotEmpty;
}

class WikiPage {

  WikiPage.parse(Map json, { this.sourceUri }) :
        displayTitle = json["displayTitle"]
  {
    List<Map> jsonSections = json["sections"];
    WikiPageSection activeSection;
    jsonSections.forEach((jsonSection) {
      if (jsonSection["toclevel"] != null) {
        int toclevel = jsonSection["toclevel"];
        while (toclevel <= activeSection?.toclevel)
          activeSection = activeSection.parent;
      } else {
        activeSection = null;
      }

      var pageSection = new WikiPageSection.parse(jsonSection, parent: activeSection);

      if (activeSection == null) {
        rootSection = pageSection;
      }

      activeSection = pageSection;
    });
  }

  WikiPage({
    this.displayTitle,
    this.sourceUri,
  });

  final String displayTitle;

  final Uri sourceUri;

  WikiPageSection rootSection;
}

class WikiHelper {

  static String siteRoot({ String language: "en" }) {
    if (language == null) {
      throw new ArgumentError.notNull("language");
    }

    var prefix = language.toLowerCase().trim();
    prefix = (prefix == "en") ? "" : "$prefix.";

    return "https://${prefix}stardewvalleywiki.com/mediawiki/api.php?format=json&action=mobileview";
  }

  static String pageBase({ String language: "en", String pageName: "Stardew_Valley_Wiki" }) {
    if (pageName == null) {
      throw new ArgumentError.notNull("pageName");
    }

    return "${siteRoot(language: language)}&page=$pageName";
  }

  static Uri buildUri({ String language: "en", String pageName: "Stardew_Valley_Wiki", Map<String, dynamic> params }) {
    var uri = Uri.parse(pageBase(language: language, pageName: pageName));
    if (params != null) {
      uri = uri.replace(
          queryParameters: {}..addAll(uri.queryParameters)..addAll(params)
      );
    }
    return uri;
  }

  static Future<WikiPage> fetchPage({ String language: "en", String pageName: "Stardew_Valley_Wiki", Map<String, dynamic> params }) {
    var requestParams = {
      "prop": "displaytitle|sections",
      "sections": "all",
      "sectionprop": "toclevel|line",
    };

    if (params != null) {
      requestParams.addAll(params);
    }

    var completer = new Completer<WikiPage>();

    HttpHelper.fetchJson(
        uri: buildUri(language: language, pageName: pageName, params: requestParams)
    ).then((HttpResponseBody<Map> jsonResponse) {
      var json = jsonResponse.body;
      completer.complete(new WikiPage.parse(json["mobileview"], sourceUri: jsonResponse.requestUri));
    }).catchError((dynamic error, StackTrace stackTrace) => completer.completeError(error, stackTrace));

    return completer.future;
  }

}