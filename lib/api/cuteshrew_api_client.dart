import 'dart:convert';

import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_create.dart';
import 'package:cuteshrew/models/comment_detail.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:http/http.dart';

class CuteshrewApiClient {
  const CuteshrewApiClient({this.baseUrl = "cuteshrew.xyz"});
  final String baseUrl;
  final String _communityUrl = "/community";
  final String _loginUrl = "/login";
  final String _userUrl = "/user/general";
  final String _pageUrl = '/page';
  final String _commentUrl = '/comment';

  final String _queryNameCountPerPage = 'count_per_page';
  final String _queryNamePassword = 'password';

  Map<String, String> makeQuery(String q, String v) => {q: v};
  Map<String, dynamic> mapCodeAndData(int c, d) => {'code': c, 'data': d};

  Future<List<Community>?> getMainPage() async {
    final url = Uri.http(baseUrl, _communityUrl);

    Response response = await get(url);

    if (response.statusCode == 200) {
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          Community.fromJson(e),
      ];
    }
    return null;
  }

  Future<Map<String, dynamic>> getPosting(String communityName, int postId,
      [String? password]) async {
    final url = Uri.http(baseUrl, "$_communityUrl/$communityName/$postId",
        password != null ? makeQuery(_queryNamePassword, password) : null);

    final response = await get(url);

    if (response.statusCode == 200) {
      var post =
          PostDetail.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return mapCodeAndData(response.statusCode, post);
    } else {
      return mapCodeAndData(response.statusCode, null);
    }
  }

  Future<LoginToken?> postLogin(String nickname, String password) async {
    Map data = {'username': nickname, 'password': password};
    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    final url = Uri.http(
      baseUrl,
      _loginUrl,
    );

    final response = await post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: encodedBody);

    if (response.statusCode == 200) {
      return LoginToken.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }

  Future<bool> deletePosting(
      String communityName, LoginToken token, int postId) async {
    final url = Uri.http(baseUrl, '$_communityUrl/$communityName/$postId');
    final response = await delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token.tokenType} ${token.accessToken}"
      },
    );

    if (response.statusCode == 204) {
      return true;
    }
    return false;
  }

  Future<Community?> getCommunity(communityName, pageNum, postingCount) async {
    final url = Uri.http(
        baseUrl,
        "$_communityUrl/$communityName$_pageUrl/$pageNum",
        makeQuery(_queryNameCountPerPage, postingCount.toString()));

    final response = await get(url);

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }

  Future<List<CommentDetail>?> getCommentPage(
      String communityName, int postId, int pageNum, int commentCount) async {
    final url = Uri.http(
        baseUrl,
        "$_communityUrl/$communityName/$postId$_commentUrl/$pageNum",
        makeQuery(_queryNameCountPerPage, commentCount.toString()));

    final response = await get(url);

    if (response.statusCode == 200) {
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommentDetail.fromJson(e),
      ];
    }
    return null;
  }

  Future<bool> uploadComment(LoginToken token, String commentName, int postId,
      CommentCreate comment) async {
    final url =
        Uri.http(baseUrl, "$_communityUrl/$commentName/$postId/$_commentUrl");

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(comment.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create comment');
    }
  }

  Future<bool> uploadReply(LoginToken token, String commentName, int postId,
      int group_id, CommentCreate comment) async {
    final url = Uri.http(
        baseUrl, "$_communityUrl/$commentName/$postId/$_commentUrl/$group_id");

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(comment.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to create reply');
    }
  }

  Future<bool> updateComment(LoginToken token, String commentName, int postId,
      int commentId, CommentCreate comment) async {
    final url = Uri.http(
        baseUrl, "$_communityUrl/$commentName/$postId/$_commentUrl/$commentId");

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(comment.toJson()));

    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to update comment');
    }
  }

  Future<bool> deleteComment(LoginToken token, String commentName, int postId,
      int commentId, CommentCreate comment) async {
    final url = Uri.http(
        baseUrl, "$_communityUrl/$commentName/$postId/$_commentUrl/$commentId");

    final response = await delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token.tokenType} ${token.accessToken}",
      },
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      throw Exception('Failed to delete comment');
    }
  }
/*
  Future<List<Community>?> getMainPage() async {
    final url = Uri.http(baseUrl, _communityUrl);

    Response response = await get(url);

    if (response.statusCode == 200) {
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          Community.fromJson(e),
      ];
    }
    return null;
  }

  Future<Community?> getCommunity(communityName, pageNum, postingCount) async {
    final url = Uri.http(
        baseUrl,
        "$_communityUrl/$communityName$_pageUrl/$pageNum",
        makeQuery(_queryNameCountPerPage, postingCount.toString()));

    final response = await get(url);

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    }
    return null;
  }

  Future<bool> postSignin(UserCreate user) async {
    final url = Uri.http(baseUrl, _userUrl);

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(user.toMap()));

    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future<bool> uploadPosting(
      String communityName, TestLoginToken token, PostCreate posting) async {
    final url = Uri.http(baseUrl, '$_communityUrl/$communityName');

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}"
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(posting.toJson()));
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  Future<bool> updatePosting(String communityName, TestLoginToken token,
      int postId, PostCreate posting) async {
    final url = Uri.http(baseUrl, '$_communityUrl/$communityName/$postId');
    final response = await put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}"
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(posting.toJson()));
    if (response.statusCode == 202) {
      return true;
    }
    return false;
  }

  
  */
}
