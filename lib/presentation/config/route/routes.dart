// ignore_for_file: constant_identifier_names, non_constant_identifier_names

class Routes {
  static const HomePageName = 'home';
  static const HomePagePath = '/home';
  static const CommunityPageName = 'community';
  static const CommunityPagePath = '/community';
  static const PostEditorPageName = 'write';
  static const PostEditorPagePath = '/write';
  static const LoginPagePath = '/login';
  static const LoginPageName = 'login';
  static const UserPagePath = '/user';
  static const UserPageName = 'user';

  static String get HomePageRoute => HomePagePath;
  static String get CommunityPageRoute => CommunityPagePath;
  static String get LoginPageRoute => LoginPagePath;
  static String get UserPageRoute => UserPagePath;
  static String get PostEditorPageRoute => PostEditorPagePath;

  static String CommuintyNamePageRoute(community) =>
      "$CommunityPagePath/$community";
  static String PostingPageRoute(community, id) =>
      "$CommunityPagePath/$community/$id";
}
