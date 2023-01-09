class HttpConstants {
  static const String cuteshrewScheme = "http";
  // static const String cuteshrewBaseUrl = "cuteshrew.xyz";
  static const String cuteshrewBaseUrl = "127.0.0.1";
  static const String endpointApi = "/apiv2";

  static const String endpointCommunity = "/community";
  static const String endpointAuth = "/auth";
  static const String endpointUser = "/user";
  static const String endpointPosting = "/posting";
  static const String endpointComment = '/comment';
  static const String endpointReply = '/reply';
  static const String endpointSearch = '/search';

  // Authentication Endpoint Function
  static const String pathSiginin = "/signin";
  static const String pathVerify = "/verify";

  // User Endpoint Path
  static const String pathGeneral = '/general';
  static const String pathSearch = '/search';

  // Comment Endpoint Path
  static const String pathReply = '/reply';

  // Community Endpoint Path
  static const String pathAll = '/all';
  static const String pathInfo = '/info';

  // Posting Endpoint Path
  static const String pathDetails = '/details';
  static const String pathPreviews = '/previews';

  // Common Function
  static const String functionList = '/list';
  static const String functionCreate = '/create';
  static const String pageUrl = '/page';

  // Query
  static const String queryCommunityName = 'community_name';
  static const String queryCommunityCount = "communitycount";
  static const String queryNameCountPerPage = 'count_per_page';
  static const String queryNamePassword = 'password';
  static const String queryUserId = 'user_id';
  static const String queryUserName = 'user_name';
  static const String querySkipUntilId = 'skip_until_id';
  static const String queryPageNum = 'page_num';
  static const String queryLoadCount = 'load_count';

  static Map<String, String> makeQuery(String q, String v) => {q: v};

  // Request URLs
  // Page URLs
  static get getMainPage => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: endpointApi + endpointCommunity);

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

  // Auth URLs
  static get requestLogin => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: endpointApi + endpointAuth + pathSiginin);

  static get requestSignup => Uri(
      host: cuteshrewBaseUrl,
      scheme: cuteshrewScheme,
      path: endpointApi + endpointUser + pathGeneral);

  // User URLs
  static getUserDetail(String userName) => Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path: "$endpointApi$endpointUser$endpointSearch",
          queryParameters: {
            queryUserName: userName,
          });

  // Community URLs
  static getCommunity(String communityName) => Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path: "$endpointApi$endpointCommunity",
          queryParameters: {
            queryCommunityName: communityName,
          });

  static getCommunities(int? loadCount) => Uri(
          host: cuteshrewBaseUrl,
          scheme: cuteshrewScheme,
          path: "$endpointApi$endpointCommunity$pathAll",
          queryParameters: {
            if (loadCount != null) queryCommunityCount: loadCount.toString(),
          });

  // Posting URLs
  static getPosting(String communityName, int postId, [String? password]) =>
      Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointPosting/$postId",
        queryParameters: {
          queryCommunityName: communityName,
          if (password != null) queryNamePassword: password,
        },
      );

  static uploadPosting(String communityName) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointPosting/$communityName",
        queryParameters: {
          queryCommunityName: communityName,
        },
      );

  static updatePosting(String communityName, int postId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointPosting/$postId",
        queryParameters: {
          queryCommunityName: communityName,
        },
      );

  static deletePosting(String communityName, int postId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: '$endpointApi$endpointPosting/$postId',
        queryParameters: {
          queryCommunityName: communityName,
        },
      );

  // Comment URI
  static getCommentList(
          String communityName, int postId, int pageNum, int commentCount) =>
      Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointComment$pageUrl/$postId/$pageNum",
        queryParameters: {
          queryLoadCount: commentCount.toString(),
        },
      );

  static uploadComment(String communityName, int postId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointComment$functionCreate/$postId",
      );

  static uploadReply(String communityName, int postId, int groupId) => Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path:
            "$endpointApi$endpointComment$endpointReply$functionCreate/$postId",
      );

  static basicCommentUrl(String communityName, int postId, int commentId) =>
      Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointComment/$commentId",
      );

  // Search
  // String으로 와야함 안그럼 버그난다
  static searchPostings(
      [int? userId, String? userName, int? skipUntilId, int? loadCount]) {
    var params = {
      if (userId != null) queryUserId: userId.toString(),
      if (userName != null) queryUserName: userName,
      if (skipUntilId != null) querySkipUntilId: skipUntilId.toString(),
      if (loadCount != null) queryLoadCount: loadCount.toString()
    };

    return Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointSearch/posting",
        queryParameters: params);
  }

  static searchComments(
      [int? userId, String? userName, int? skipUntilId, int? loadCount]) {
    var params = {
      if (userId != null) queryUserId: userId.toString(),
      if (userName != null) queryUserName: userName,
      if (skipUntilId != null) querySkipUntilId: skipUntilId.toString(),
      if (loadCount != null) queryLoadCount: loadCount.toString()
    };

    return Uri(
        host: cuteshrewBaseUrl,
        scheme: cuteshrewScheme,
        path: "$endpointApi$endpointSearch/comment",
        queryParameters: params);
  }
}
