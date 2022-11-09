import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/auth/auth_page.dart';
import 'package:cuteshrew/pages/community/community_page.dart';
import 'package:cuteshrew/pages/error_page.dart';
import 'package:cuteshrew/pages/home/home_page.dart';
import 'package:cuteshrew/pages/post_editor/post_editor_page.dart';
import 'package:cuteshrew/pages/posting/posting_page.dart';
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

//FIXME 무의미하게 communityInfo를 받는 것을 communityName으로 바꿔야함
Route<dynamic> generateRoute(RouteSettings settings) {
  var uri = Uri.parse(settings.name ?? "");

  print(uri.toString());
  print(uri.pathSegments.length.toString());

  if (uri.pathSegments.length == 1) {
    switch (uri.pathSegments.first) {
      case Routes.HomePageName:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case Routes.CommunityPageName:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
      case Routes.LoginPageName:
        return MaterialPageRoute(
          builder: (context) => const AuthPage(),
        );
      // case Routes.PostEditorPageName:
      //   var args;
      //   if (settings.arguments != null) {
      //     args = settings.arguments;
      //   } else {
      //     args = PostEditorPageArguments(null, false);
      //   }
      //   return MaterialPageRoute(
      //     builder: (context) => PostEditorPage(
      //         communityInfo: Community(
      //             communityName: "",
      //             communityShowName: "",
      //             latestPostingList: [],
      //             postingsCount: 0),
      //         originPost: args.originPost,
      //         isModify: args.isModify),
      //   );
      default:
    }
  }

  if (uri.pathSegments.length == 2) {
    if (uri.pathSegments.first == Routes.CommunityPageName) {
      String communityName = uri.pathSegments[1];
      return MaterialPageRoute(
        builder: (context) => CommunityPage(
            communityInfo: Community(
                communityName: communityName,
                communityShowName: communityName,
                latestPostingList: [],
                postingsCount: 0),
            currentPageNum: 0),
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
          builder: (context) => PostEditorPage(
              communityInfo: Community(
                  communityName: communityName,
                  communityShowName: communityName,
                  latestPostingList: [],
                  postingsCount: 0),
              originPost: args.originPost,
              isModify: args.isModify),
        );
      } else {
        return MaterialPageRoute(
          builder: (context) => PostingPage(
            communityInfo: Community(
                communityName: communityName,
                communityShowName: communityName,
                latestPostingList: [],
                postingsCount: 0),
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
            communityInfo: Community(
                communityName: communityName,
                communityShowName: communityName,
                latestPostingList: [],
                postingsCount: 0),
            currentPageNum: int.parse(uri.pathSegments[3])),
      );
    }
  }

  return MaterialPageRoute(
    builder: (context) => PageNotFound(),
  );
}

PageRoute _getPageRoute(Widget child) {
  return MaterialPageRoute(builder: (context) => child);
}
