import 'package:cuteshrew/pages/auth/auth_page.dart';
import 'package:cuteshrew/pages/community/community_page.dart';
import 'package:cuteshrew/pages/error_page.dart';
import 'package:cuteshrew/pages/home/home_page.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:flutter/material.dart';
/*
  URL 리스트
  /home: 일단은 /community로 대체
  /community: 모든 커뮤니티 메뉴
  /community/{name}: name 이름의 커뮤니티 페이지
  /community/{name}/{postId}: name 이름 커뮤니티 아래의 postId번호를 가진 게시글 페이지
  /community/{name}/write: 게시글 작성 페이지
  /login: 로그인 페이지
*/

Route<dynamic> generateRoute(RouteSettings settings) {
  var uri = Uri.parse(settings.name ?? "");

  if (uri.pathSegments.length == 1) {
    switch (uri.pathSegments.first) {
      case HomePageName:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case CommunityPageName:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case LoginPageName:
        return MaterialPageRoute(
          builder: (context) => const AuthPage(),
        );
      default:
    }
  }

  // if (uri.pathSegments.length == 2) {
  //   if (uri.pathSegments.first == CommunityPageName) {
  //     var communityInfo = settings.arguments;
  //     return MaterialPageRoute(
  //       builder: (context) => CommunityPage(communityInfo: communityInfo),
  //     );
  //   }
  // }

  return MaterialPageRoute(
    builder: (context) => PageNotFound(),
  );
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
