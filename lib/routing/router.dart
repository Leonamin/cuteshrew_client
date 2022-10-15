import 'package:cuteshrew/pages/auth_page.dart';
import 'package:cuteshrew/pages/auth_screen_page.dart';
import 'package:cuteshrew/pages/community_page.dart';
import 'package:cuteshrew/pages/error_page.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/pages/posting_page.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case CommunityHomePageRoute:
    //   return _getPageRoute(HomePage());
    case CommunityPageRoute:
      return _getPageRoute(CommunityPage(settings.arguments as dynamic));
    case PostingPageRoute:
      return _getPageRoute(PostingPage(settings.arguments as dynamic));
    case PostEditorPageRoute:
      return _getPageRoute(PostEditorPage(settings.arguments as dynamic));
    case AuthenticationPageRoute:
      return _getPageRoute(AuthScreenPage());

    default:
      return _getPageRoute(PageNotFound());
  }
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
