import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/presentation/screens/auth/auth_page.dart';
import 'package:cuteshrew/presentation/screens/posting_editor/posting_editor_page.dart';
import 'package:cuteshrew/presentation/screens/community/community_page.dart';
import 'package:cuteshrew/presentation/screens/home/page/home_page.dart';
import 'package:cuteshrew/presentation/screens/notfound/error_page.dart';
import 'package:cuteshrew/presentation/screens/posting/posting_page.dart';
import 'package:cuteshrew/presentation/screens/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/extension/string_extenstion.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final routingData = settings.name!.getRoutingData;
  final uri = Uri.parse(routingData.route);

  if (uri.pathSegments.length == 1) {
    switch (uri.pathSegments.first) {
      case Routes.HomePageName:
      // 나중에 기능이 여러개 생기면 HomePage와 CommunityPage가 분기될 것이다.
      case Routes.CommunityPageName:
        return _getPageRoute(const HomePage(), settings);
      case Routes.LoginPageName:
        return _getPageRoute(const AuthPage(), settings);

      case Routes.PostEditorPageName:
        var args;
        if (settings.arguments != null) {
          args = settings.arguments;
        } else {
          args = PostEditorPageArguments(null, false);
        }
        return MaterialPageRoute(
          settings: settings,
          builder: (context) => PostingEditorPage(
              communityName: "",
              originPost: args.originPost,
              isModify: args.isModify),
        );
      default:
    }
  }

  if (uri.pathSegments.length == 2) {
    if (uri.pathSegments.first == Routes.CommunityPageName) {
      final String communityName = routingData['communityName'];
      print(communityName);
      // String communityName = uri.pathSegments[1];
      return _getPageRoute(
          CommunityPage(communityName: communityName), settings);
      return MaterialPageRoute(
        builder: (context) =>
            CommunityPage(communityName: communityName, currentPageNum: 0),
      );
    }
    if (uri.pathSegments.first == Routes.UserPageName) {
      String userName = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (context) => UserPage(
          userName: userName,
        ),
      );
    }
  }

  if (uri.pathSegments.length == 3) {
    if (uri.pathSegments.first == Routes.CommunityPageName) {
      String communityName = uri.pathSegments[1];

      if (uri.pathSegments[2] == Routes.PostEditorPageName) {
        var args;
        if (settings.arguments != null) {
          args = settings.arguments;
        } else {
          args = PostEditorPageArguments(null, false);
        }
        return MaterialPageRoute(
          builder: (context) => PostingEditorPage(
              communityName: communityName,
              originPost: args.originPost,
              isModify: args.isModify),
        );
      } else {
        return MaterialPageRoute(
          builder: (context) => PostingPage(
            communityName: communityName,
            postId: int.parse(uri.pathSegments[2]),
          ),
        );
      }
    }
  }

  if (uri.pathSegments.length == 4) {
    if (uri.pathSegments.first == Routes.CommunityPageName &&
        uri.pathSegments[2] == 'page') {
      String communityName = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (context) => CommunityPage(
            communityName: communityName,
            currentPageNum: int.parse(uri.pathSegments[3])),
      );
    }
  }

  return MaterialPageRoute(
    builder: (context) => const PageNotFound(),
  );
}

PageRoute _getPageRoute(Widget child, RouteSettings settings) {
  return _FadeRoute(child: child, routeName: settings.name ?? "");
}

class _FadeRoute extends PageRouteBuilder {
  final Widget child;
  final String routeName;
  _FadeRoute({required this.child, required this.routeName})
      : super(
          settings: RouteSettings(name: routeName),
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              child,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: child,
          ),
        );
}
