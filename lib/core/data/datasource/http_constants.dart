class HttpConstants {
  static const String cuteshrewScheme = "http";
  static const String cuteshrewBaseUrl = "cuteshrew.xyz";
  static const String apiUrl = "/api";
  static const String endpointCommunity = "/community";
  static const String endpointLogin = "/login";
  static const String endpointUser = "/user/general";
  static const String endpointComment = '/comment';
  static endpointPosting(String communityName) =>
      "$endpointCommunity/$communityName";
  static const String pageUrl = '/page';
  static const String endpointSearch = '/search';

  static const String queryCommunityCount = "community_count";
  static const String queryNameCountPerPage = 'count_per_page';
  static const String queryNamePassword = 'password';
  static const String queryUserId = 'user_id';
  static const String queryUserName = 'user_name';
  static const String queryStartId = 'start_id';
  static const String queryLoadPageNum = 'load_page_num';
}
