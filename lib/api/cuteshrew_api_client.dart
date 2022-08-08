import 'dart:convert';

import 'package:cuteshrew/models/login_token.dart';
import 'package:http/http.dart';

class CuteshrewApiClient {
  const CuteshrewApiClient({this.baseUrl = "cuteshrew.xyz"});
  final String baseUrl;
  final String _communityUrl = "/community";
  final String _loginUrl = "/login";
  final String _userUrl = "/user/general";
  final String _pageUrl = '/page';

  final String _queryNameCountPerPage = 'count_per_page';
  final String _queryNamePassword = 'password';

  Map<String, String> makeQuery(String q, String v) => {q: v};
  Map<String, dynamic> mapCodeAndData(int c, d) => {'code': c, 'data': d};

  Future<LoginToken?> postLogin(nickname, password) async {
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

  Future<Map<String, dynamic>> getPosting(communityName, postId,
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

  Future<bool> deletePosting(
      String communityName, TestLoginToken token, int postId) async {
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
  */
}
