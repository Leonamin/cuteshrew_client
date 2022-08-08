import 'dart:convert';

import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:http/http.dart';

class HttpService {
  final String baseUrl = "cuteshrew.xyz";
  // final String baseUrl = "127.0.0.1"; //debug
  final String communityUrl = "/community";
  final String loginUrl = "/login";
  final String userUrl = "/user/general";
  final String pageUrl = '/page';

  final String queryCountPerPage = 'count_per_page';
  final String queryPassword = 'password';

  var makeQuery = ((String q, String v) => {q: v});
  var mapCodeAndData = ((int c, d) => {'code': c, 'data': d});

  Future<List<Community>> getMainPage() async {
    final url = Uri.http(baseUrl, communityUrl);

    Response response = await get(url);

    if (response.statusCode == 200) {
      // Iterable l = json.decode(response.body);
      // List<Community> communities =
      //     List<Community>.from(l.map((model) => Community.fromJson(model)));

      // return communities;
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          Community.fromJson(e),
      ];
    } else {
      throw Exception('Failed to load main page');
    }
  }

  Future<Community> getCommunity(communityName, pageNum, postingCount) async {
    final url = Uri.http(
        baseUrl,
        "$communityUrl/$communityName$pageUrl/$pageNum",
        makeQuery(queryCountPerPage, postingCount.toString()));

    final response = await get(url);

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load $communityName page');
    }
  }

  Future<Map<String, dynamic>> getPosting(communityName, postId,
      [String? password]) async {
    final url = Uri.http(baseUrl, "$communityUrl/$communityName/$postId",
        password != null ? makeQuery(queryPassword, password) : null);

    final response = await get(url);

    if (response.statusCode == 200) {
      var post =
          PostDetail.fromJson(json.decode(utf8.decode(response.bodyBytes)));
      return mapCodeAndData(response.statusCode, post);
    } else {
      return mapCodeAndData(response.statusCode, null);
    }
  }

  Future<LoginToken> postLogin(nickname, password) async {
    Map data = {'username': nickname, 'password': password};
    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    final url = Uri.http(
      baseUrl,
      loginUrl,
    );

    final response = await post(url,
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: encodedBody);

    if (response.statusCode == 200) {
      return LoginToken.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> postSignin(UserCreate user) async {
    final url = Uri.http(baseUrl, userUrl);

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(user.toMap()));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> uploadPosting(
      String communityName, LoginToken token, PostCreate posting) async {
    final url = Uri.http(baseUrl, '$communityUrl/$communityName');

    final response = await post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}"
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(posting.toJson()));
    if (response.statusCode == 201) {
      return true;
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<bool> updatePosting(String communityName, LoginToken token, int postId,
      PostCreate posting) async {
    final url = Uri.http(baseUrl, '$communityUrl/$communityName/$postId');
    final response = await put(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "${token.tokenType} ${token.accessToken}"
        },
        encoding: Encoding.getByName('utf-8'),
        body: jsonEncode(posting.toJson()));
    if (response.statusCode == 202) {
      return true;
    } else {
      return false;
      // throw Exception('Failed to update post ${response.body}');
    }
  }

  Future<bool> deletePosting(
      String communityName, LoginToken token, int postId) async {
    final url = Uri.http(baseUrl, '$communityUrl/$communityName/$postId');
    final response = await delete(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "${token.tokenType} ${token.accessToken}"
      },
    );

    if (response.statusCode == 204) {
      return true;
    } else {
      return false;
      // throw Exception('Failed to delete post ${response.body}');
    }
  }
}
