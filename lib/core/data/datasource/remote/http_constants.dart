class HttpConstants {
  static const String cuteshrewScheme = "http";
  static const String cuteshrewBaseUrl = "cuteshrew.xyz";
  static const String endpointApi = "/api";
  static const String endpointCommunity = "/community";
  static const String endpointLogin = "/login";
  static const String endpointUser = "/user";
  static const String endpointPosting = "/posting";
  static const String endpointComment = '/comment';
  static const String endpointSearch = '/search';
  static const String pageUrl = '/page';

  static const String queryCommunityCount = "communitycount";
  static const String queryNameCountPerPage = 'count_per_page';
  static const String queryNamePassword = 'password';
  static const String queryUserId = 'user_id';
  static const String queryUserName = 'user_name';
  static const String queryStartId = 'start_id';
  static const String queryLoadPageNum = 'load_page_num';

  static Map<String, String> makeQuery(String q, String v) => {q: v};
  // MainPage URI
  static get getMainPage => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: endpointApi + endpointCommunity);

  static getCommunity(String communityName) => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: "$endpointApi$endpointCommunity/$communityName");

  static getCommunities(int? loadCount) => Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path: "$endpointApi$endpointCommunity",
          queryParameters: {
            if (loadCount != null) queryCommunityCount: loadCount.toString(),
          });

  // Login URI
  static get requestLogin => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: endpointApi + endpointLogin);

  static get requestSignin => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: endpointApi + endpointUser);

  // Community URI
  static getCommunityPage(
          String communityName, int pageNum, int? postingCount) =>
      Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path:
              "$endpointApi$endpointCommunity/$communityName$pageUrl/$pageNum",
          queryParameters: {
            if (postingCount != null)
              queryNameCountPerPage: postingCount.toString()
          });

  // Posting URI
  static getPosting(String communityName, int postId, [String? password]) =>
      Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path: "$endpointApi$endpointCommunity/$communityName/$postId",
          queryParameters:
              password != null ? makeQuery(queryNamePassword, password) : null);

  static uploadPosting(String communityName) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointCommunity/$communityName",
      );

  static updatePosting(String communityName, int postId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointCommunity/$communityName/$postId",
      );

  static deletePosting(String communityName, int postId) => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: '$endpointApi$endpointCommunity/$communityName/$postId');

  // Comment URI
  static getCommentList(
          String communityName, int postId, int pageNum, int commentCount) =>
      Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path:
              "$endpointApi$endpointCommunity/$communityName/$postId$endpointComment/$pageNum",
          queryParameters:
              makeQuery(queryNameCountPerPage, commentCount.toString()));

  static uploadComment(String communityName, int postId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path:
            "$endpointApi$endpointCommunity/$communityName/$postId$endpointComment",
      );

  static uploadReply(String communityName, int postId, int groupId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path:
            "$endpointApi$endpointCommunity/$communityName/$postId$endpointComment/$groupId",
      );

  static basicCommentUrl(String communityName, int postId, int commentId) =>
      Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path:
            "$endpointApi$endpointCommunity/$communityName/$postId$endpointComment/$commentId",
      );

  static getUserDetail(String userName) => Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path: "$endpointApi$endpointUser$endpointSearch",
          queryParameters: {
            queryUserName: userName,
          });

  // Search
  // String으로 와야함 안그럼 버그난다
  static searchPostings(
      [int? userId, String? userName, int? startPostId, int? loadPageNum]) {
    var params = {
      if (userId != null) queryUserId: userId.toString(),
      if (userName != null) queryUserName: userName,
      if (startPostId != null) queryStartId: startPostId.toString(),
      if (loadPageNum != null) queryLoadPageNum: loadPageNum.toString()
    };

    return Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointSearch/posting",
        queryParameters: params);
  }

  static searchComments(
      [int? userId, String? userName, int? startId, int? loadPageNum]) {
    var params = {
      if (userId != null) queryUserId: userId.toString(),
      if (userName != null) queryUserName: userName,
      if (startId != null) queryStartId: startId.toString(),
      if (loadPageNum != null) queryLoadPageNum: loadPageNum.toString()
    };

    return Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointSearch/comment",
        queryParameters: params);
  }
}
