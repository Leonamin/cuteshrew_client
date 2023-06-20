import 'dart:convert';

import 'package:cuteshrew/data/remote/auth/login_token_res.dart';
import 'package:cuteshrew/data/remote/comment/comment_req.dart';
import 'package:cuteshrew/data/remote/comment/comment_res.dart';
import 'package:cuteshrew/data/remote/community/community_res.dart';
import 'package:cuteshrew/data/remote/dio_factory.dart';
import 'package:cuteshrew/data/remote/posting/posting_req.dart';
import 'package:cuteshrew/data/remote/posting/posting_res.dart';
import 'package:cuteshrew/data/remote/user/user_req.dart';
import 'package:cuteshrew/data/remote/user/user_res.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:dio/dio.dart';

class ApiCuteShrew {
  ApiCuteShrew._();
  static final ApiCuteShrew _instance = ApiCuteShrew._();

  factory ApiCuteShrew() {
    return _instance;
  }

  final Dio _dio = DioFactory.getDioClientForCuteShrew();

  // Auth
  Future<LoginTokenRes> requestLogin(String nickname, String password) async {
    Map data = {'username': nickname, 'password': password};
    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    final result = await _dio.post(
      '/auth/signin',
      options: Options(contentType: 'application/x-www-form-urlencoded'),
      data: encodedBody,
    );

    return LoginTokenRes.fromJson(result.data);
  }

  // Community
  Future<CommunityRes> getCommunityPage(String communityName,
      [int pageNum = 1, int? loadCount]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'count_per_page', loadCount);
    final response = await _dio.get('/community/$communityName/page/$pageNum',
        queryParameters: queryParameters);
    return CommunityRes.fromJson(response.data);
  }

  Future<List<CommunityRes>> getCommunityList([int? loadCommunityCount]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'load_count', loadCommunityCount);
    final response =
        await _dio.get('/community/all', queryParameters: queryParameters);

    return (jsonDecode(response.data) as List)
        .map((e) => CommunityRes.fromJson(e))
        .toList();
  }

  Future<List<CommunityRes>> getMainCommunityList() async {
    final response = await _dio.get('/community/main');
    return [
      for (final e in jsonDecode(response.data)) CommunityRes.fromJson(e)
    ];
  }

  Future<CommunityRes> getCommunityInfo(String communityName,
      [int pageNum = 1, int? loadCount]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'load_count', loadCount);
    final response = await _dio.get('/community/$communityName/info',
        queryParameters: queryParameters);
    return CommunityRes.fromJson(response.data);
  }

  // Posting
  Future<PostingRes> getPosting(String communityName, String postingId,
      [String? password]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'password', password);
    final response =
        await _dio.get('/posting/$postingId', queryParameters: queryParameters);
    return PostingRes.fromJson(response.data);
  }

  Future<List<PostingRes>> getPostingSummaryList(String communityName,
      [int pageNum = 1, int? loadCount]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'page_num', pageNum);
    _setQueryParam(queryParameters, 'load_count', loadCount);
    final response =
        await _dio.get('/posting/previews', queryParameters: queryParameters);
    return [for (final e in jsonDecode(response.data)) PostingRes.fromJson(e)];
  }

  Future<void> uploadPosting(
      String communityName, LoginToken token, PostingReq req) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'community_name', communityName);
    await _dio.post(
      '/posting',
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
      data: req.toJson(),
    );
  }

  Future<void> updatePosting(String communityName, int postId, LoginToken token,
      PostingReq req) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'community_name', communityName);
    await _dio.put(
      '/posting/$postId',
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
      data: req.toJson(),
    );
  }

  Future<void> deletePosting(
    String communityName,
    int postId,
    LoginToken token,
  ) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'community_name', communityName);
    await _dio.delete(
      '/posting/$postId',
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
    );
  }

  Future<List<PostingRes>> searchPostings([
    String? userName,
    int? startPostId,
    int? loadPageNum,
  ]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'user_name', userName);
    _setQueryParam(queryParameters, 'skip_until_id', startPostId);
    _setQueryParam(queryParameters, 'load_count', loadPageNum);

    final response =
        await _dio.get('/search/posting', queryParameters: queryParameters);
    return [for (final e in jsonDecode(response.data)) PostingRes.fromJson(e)];
  }

  // Comment

  Future<List<CommentRes>> getCommentList(
    String communityName,
    int postId,
    int pageNum,
    int commentCount,
  ) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'load_count', commentCount);

    final response = await _dio.get(
      '/comment/page/$postId/comment/$pageNum',
      queryParameters: queryParameters,
    );
    return [for (final e in jsonDecode(response.data)) CommentRes.fromJson(e)];
  }

  Future<void> uploadComment(
    int postId,
    LoginToken token,
    CommentReq comment,
  ) async {
    await _dio.post(
      '/comment/create/$postId',
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
      data: comment.toJson(),
    );
  }

  Future<void> updateComment(
    int commentId,
    LoginToken token,
    CommentReq comment,
  ) async {
    await _dio.post(
      '/comment/$commentId',
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
      data: comment.toJson(),
    );
  }

  Future<void> deleteComment(
    int commentId,
    LoginToken token,
  ) async {
    await _dio.delete(
      '/comment/$commentId',
      options: Options(
        contentType: 'application/json',
        headers: {
          'Authorization': '${token.tokenType} ${token.accessToken}',
        },
      ),
    );
  }

  Future<List<CommentRes>> searchComments([
    String? userName,
    int? startPostId,
    int? loadPageNum,
  ]) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'user_name', userName);
    _setQueryParam(queryParameters, 'skip_until_id', startPostId);
    _setQueryParam(queryParameters, 'load_count', loadPageNum);

    final response =
        await _dio.get('/search/comment', queryParameters: queryParameters);
    return [for (final e in jsonDecode(response.data)) CommentRes.fromJson(e)];
  }

  // User
  Future<void> requestSignUp(UserReq user) async {
    await _dio.post(
      '/user/general',
      options: Options(contentType: 'application/json'),
      data: user.toJson(),
    );
  }

  Future<UserRes> getUserDetail(String userName) async {
    Map<String, dynamic> queryParameters = {};
    _setQueryParam(queryParameters, 'user_name', userName);
    final response =
        await _dio.get('/user/search', queryParameters: queryParameters);
    return UserRes.fromJson(response.data);
  }

  // ETC

  void _setQueryParam(
      Map<String, dynamic> queryParam, String key, dynamic value) {
    if (value != null) queryParam[key] = value;
  }
}
