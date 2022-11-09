// const RootRoute = "/";
// const CommunityHomePageDisplayName = "Homepage";
// const CommunityHomePageRoute = "/home";
// const CommunityPageDisplayName = "Community";
// const CommunityPageRoute = "/community";
// const PostingPageDisplayName = "Posting";
// const PostingPageRoute = "/posting";
// const PostEditorPageDisplayName = "Post Editor";
// const PostEditorPageRoute = "/editor";
// const AuthenticationPageDisplayName = "Authentication";
// const AuthenticationPageRoute = "/auth";
class Routes {
  static const HomePageName = 'home';
  static const HomePagePath = '/home';
  static const CommunityPageName = 'community';
  static const CommunityPagePath = '/community';
  static const PostEditorPageName = 'write';
  static const PostEditorPagePath = '/write';
  static const LoginPagePath = '/login';
  static const LoginPageName = 'login';

  static String get HomePageRoute => HomePagePath;
  static String get CommunityPageRoute => CommunityPagePath;
  static String get LoginPageRoute => LoginPagePath;
  static String CommuintyNamePageRoute(community) =>
      "$CommunityPagePath/$community";
  static String PostingPageRoute(community, id) =>
      "$CommunityPagePath/$community/$id";
  static String PostEditorPageRoute(community) =>
      "$CommunityPagePath/$community$PostEditorPagePath";
}
