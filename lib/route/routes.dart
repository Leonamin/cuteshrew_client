import 'package:cuteshrew/pages/auth_page.dart';
import 'package:cuteshrew/pages/community_page.dart';
import 'package:cuteshrew/pages/home_page.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/pages/posting_page.dart';
import 'package:flutter/material.dart';

class RouteManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HomePage.pageName:
        return MaterialPageRoute(builder: (context) => HomePage());
      case CommunityPage.pageName:
        return MaterialPageRoute(
            builder: (context) =>
                CommunityPage(settings.arguments as Map<String, String>));
      case PostingPage.pageName:
        return MaterialPageRoute(
            builder: (context) =>
                PostingPage(settings.arguments as Map<String, dynamic>));
      case PostEditorPage.pageName:
        return MaterialPageRoute(
            builder: (context) =>
                PostEditorPage(settings.arguments as Map<String, dynamic>));
      case AuthPage.pageName:
        return MaterialPageRoute(builder: (context) => AuthWidget());
      default:
        throw FormatException('Route not found');
    }
  }
}
