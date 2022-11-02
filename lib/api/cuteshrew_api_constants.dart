class CuteShrewApiConstants {
  static const String scheme = "https";
  static const String baseUrl = "cuteshrew.xyz";
  static const String _communityUrl = "/community";
  static const String _loginUrl = "/login";
  static const String _userUrl = "/user/general";
  static const String _pageUrl = '/page';
  static const String _commentUrl = '/comment';

  static const String _queryNameCountPerPage = 'count_per_page';
  static const String _queryNamePassword = 'password';

  static Map<String, String> makeQuery(String q, v) => {q: v};
  // MainPage URI
  static get getMainPage =>
      Uri(host: baseUrl, scheme: scheme, path: _commentUrl);

  // Login URI
  static get requestLogin =>
      Uri(host: baseUrl, scheme: scheme, path: _loginUrl);

  // Community URI
  static getCommunity(String communityName, int pageNum, int postingCount) =>
      Uri(
          host: baseUrl,
          scheme: scheme,
          path: "$_communityUrl/$communityName$_pageUrl/$pageNum",
          query: makeQuery(_queryNameCountPerPage, postingCount).toString());

  // Posting URI
  static getPosting(String communityName, int postId, [String? password]) =>
      Uri(
          host: baseUrl,
          scheme: scheme,
          path: "$_communityUrl/$communityName/$postId",
          query: password != null
              ? makeQuery(_queryNamePassword, password).toString()
              : null);

  static uploadPosting(String communityName) => Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_communityUrl/$communityName",
      );

  static deletePosting(String communityName, int postId) => Uri(
      host: baseUrl,
      scheme: scheme,
      path: '$_communityUrl/$communityName/$postId');

  // Comment URI
  static getCommentList(
          String communityName, int postId, int pageNum, int commentCount) =>
      Uri(
          host: baseUrl,
          scheme: scheme,
          path: "$_communityUrl/$communityName/$postId$_commentUrl/$pageNum",
          query: makeQuery(_queryNameCountPerPage, commentCount).toString());

  static uploadComment(String communityName, int postId) => Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_communityUrl/$communityName/$postId$_commentUrl",
      );

  static uploadReply(String communityName, int postId, int groupId) => Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_communityUrl/$communityName/$postId$_commentUrl/$groupId",
      );

  static basicCommentUrl(String communityName, int postId, int commentId) =>
      Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_communityUrl/$communityName/$postId/$_commentUrl/$commentId",
      );
}
