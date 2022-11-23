class CuteShrewApiConstants {
  static const String scheme = "http";
  static const String baseUrl = "cuteshrew.xyz";
  static const String _apiUrl = "/api";
  static const String _communityUrl = "/community";
  static const String _loginUrl = "/login";
  static const String _userUrl = "/user/general";
  static const String _pageUrl = '/page';
  static const String _commentUrl = '/comment';
  static const String _searchUrl = '/search';

  static const String _queryNameCountPerPage = 'count_per_page';
  static const String _queryNamePassword = 'password';

  static const String _queryUserId = 'user_id';
  static const String _queryUserName = 'user_name';
  static const String _queryStartId = 'start_id';
  static const String _queryLoadPageNum = 'load_page_num';

  static Map<String, String> makeQuery(String q, String v) => {q: v};
  // MainPage URI
  static get getMainPage =>
      Uri(host: baseUrl, scheme: scheme, path: _apiUrl + _communityUrl);

  // Login URI
  static get requestLogin =>
      Uri(host: baseUrl, scheme: scheme, path: _apiUrl + _loginUrl);

  static get requestSignin =>
      Uri(host: baseUrl, scheme: scheme, path: _apiUrl + _userUrl);

  // Community URI
  static getCommunity(String communityName, int pageNum, int postingCount) =>
      Uri(
          host: baseUrl,
          scheme: scheme,
          path: "$_apiUrl$_communityUrl/$communityName$_pageUrl/$pageNum",
          queryParameters:
              makeQuery(_queryNameCountPerPage, postingCount.toString()));

  // Posting URI
  static getPosting(String communityName, int postId, [String? password]) =>
      Uri(
          host: baseUrl,
          scheme: scheme,
          path: "$_apiUrl$_communityUrl/$communityName/$postId",
          queryParameters: password != null
              ? makeQuery(_queryNamePassword, password)
              : null);

  static uploadPosting(String communityName) => Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_apiUrl$_communityUrl/$communityName",
      );

  static updatePosting(String communityName, int postId) => Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_apiUrl$_communityUrl/$communityName/$postId",
      );

  static deletePosting(String communityName, int postId) => Uri(
      host: baseUrl,
      scheme: scheme,
      path: '$_apiUrl$_communityUrl/$communityName/$postId');

  // Comment URI
  static getCommentList(
          String communityName, int postId, int pageNum, int commentCount) =>
      Uri(
          host: baseUrl,
          scheme: scheme,
          path:
              "$_apiUrl$_communityUrl/$communityName/$postId$_commentUrl/$pageNum",
          queryParameters:
              makeQuery(_queryNameCountPerPage, commentCount.toString()));

  static uploadComment(String communityName, int postId) => Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_apiUrl$_communityUrl/$communityName/$postId$_commentUrl",
      );

  static uploadReply(String communityName, int postId, int groupId) => Uri(
        host: baseUrl,
        scheme: scheme,
        path:
            "$_apiUrl$_communityUrl/$communityName/$postId$_commentUrl/$groupId",
      );

  static basicCommentUrl(String communityName, int postId, int commentId) =>
      Uri(
        host: baseUrl,
        scheme: scheme,
        path:
            "$_apiUrl$_communityUrl/$communityName/$postId$_commentUrl/$commentId",
      );

  // String으로 와야함 안그럼 버그난다
  static searchPostings(
      [int? userId, String? userName, int? startPostId, int? loadPageNum]) {
    var params = {
      if (userId != null) _queryUserId: userId.toString(),
      if (userName != null) _queryUserName: userName,
      if (startPostId != null) _queryStartId: startPostId.toString(),
      if (loadPageNum != null) _queryLoadPageNum: loadPageNum.toString()
    };

    return Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_apiUrl$_searchUrl/posting",
        queryParameters: params);
  }

  static searchComments(
      [int? userId, String? userName, int? startId, int? loadPageNum]) {
    var params = {
      if (userId != null) _queryUserId: userId.toString(),
      if (userName != null) _queryUserName: userName,
      if (startId != null) _queryStartId: startId.toString(),
      if (loadPageNum != null) _queryLoadPageNum: loadPageNum.toString()
    };

    return Uri(
        host: baseUrl,
        scheme: scheme,
        path: "$_apiUrl$_searchUrl/comment",
        queryParameters: params);
  }
}
