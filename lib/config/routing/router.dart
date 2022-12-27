/*
  URL 리스트
  /home: 일단은 /community로 대체
  /community: 모든 커뮤니티 메뉴
  /community/{name}: name 이름의 커뮤니티 페이지
  /community/{name}/{postId}: name 이름 커뮤니티 아래의 postId번호를 가진 게시글 페이지
  /community/{name}/write: 게시글 작성 페이지
  /login: 로그인 페이지
*/

import 'package:cuteshrew/config/routing/routes.dart';
import 'package:cuteshrew/presentation/screens/auth/auth_page.dart';
import 'package:cuteshrew/presentation/screens/community/community_page.dart';
import 'package:cuteshrew/presentation/screens/home/page/home_page.dart';
import 'package:cuteshrew/presentation/screens/notfound/error_page.dart';
import 'package:cuteshrew/presentation/screens/user/user_page.dart';
import 'package:flutter/material.dart';

//FIXME 무의미하게 communityInfo를 받는 것을 communityName으로 바꿔야함

Route<dynamic> generateRoute(RouteSettings settings) {
  var uri = Uri.parse(settings.name ?? "");

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

  // if (uri.pathSegments.length == 3) {
  //   if (uri.pathSegments.first == Routes.CommunityPageName) {
  //     String communityName = uri.pathSegments[1];

  //     if (uri.pathSegments[2] == Routes.PostEditorPageName) {
  //       var args;
  //       if (settings.arguments != null) {
  //         args = settings.arguments;
  //       } else {
  //         args = PostEditorPageArguments(null, false);
  //       }
  //       return MaterialPageRoute(
  //         builder: (context) => PostEditorPage(
  //             communityInfo: Community(
  //                 communityName: communityName,
  //                 communityShowName: communityName,
  //                 latestPostingList: [],
  //                 postingsCount: 0),
  //             originPost: args.originPost,
  //             isModify: args.isModify),
  //       );
  //     } else {
  //       return MaterialPageRoute(
  //         builder: (context) => PostingPage(
  //           communityName: communityName,
  //           postId: int.parse(uri.pathSegments[2]),
  //         ),
  //       );
  //     }
  //   }
  // }

  // if (uri.pathSegments.length == 4) {
  //   if (uri.pathSegments.first == Routes.CommunityPageName &&
  //       uri.pathSegments[2] == 'page') {
  //     String communityName = uri.pathSegments[1];
  //     return MaterialPageRoute(
  //       builder: (context) => CommunityPage(
  //           communityName: communityName,
  //           currentPageNum: int.parse(uri.pathSegments[3])),
  //     );
  //   }
  // }

  return MaterialPageRoute(
    builder: (context) => const PageNotFound(),
  );
}
