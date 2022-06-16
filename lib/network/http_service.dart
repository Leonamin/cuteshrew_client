import 'dart:convert';

import 'package:cuteshrew/model/models.dart';
import 'package:http/http.dart';

class HttpService {
  final String baseUrl = "http://cuteshrew.xyz";
  // final String baseUrl = "http://127.0.0.1"; //debug
  final String communityUrl = "/community";
  final String loginUrl = "/login";

  Future<List<Community>> getMainPage() async {
    Response response = await get(Uri.parse(baseUrl + communityUrl));

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

  Future<Community> getCommunity(communityName) async {
    final response =
        await get(Uri.parse("$baseUrl$communityUrl/$communityName"));

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load $communityName page');
    }
  }

  Future<PostDetail> getPosting(communityName, postId) async {
    final response =
        await get(Uri.parse("$baseUrl$communityUrl/$communityName/$postId"));

    if (response.statusCode == 200) {
      return PostDetail.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to load $communityName page');
    }
  }

  Future<LoginToken> postLogin(nickname, password) async {
    Map data = {'username': nickname, 'password': password};
    // Map data = Login(nickname, password).toMap();
    String encodedBody = data.keys.map((key) => "$key=${data[key]}").join("&");

    final response = await post(Uri.parse("$baseUrl$loginUrl"),
        headers: {
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: encodedBody);
    // body: 'username=$nickname&password=$password');

    if (response.statusCode == 200) {
      return LoginToken.fromJson(json.decode(utf8.decode(response.bodyBytes)));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<String> uploadPosting(
      String communityName, LoginToken token, PostCreate posting) async {
    final response =
        await post(Uri.parse("$baseUrl$communityUrl/$communityName"),
            headers: {
              "Content-Type": "application/json",
              "Authorization": "${token.tokenType} ${token.accessToken}"
            },
            encoding: Encoding.getByName('utf-8'),
            body: jsonEncode(posting.toJson()));
    if (response.statusCode == 200) {
      return "Success";
    } else {
      throw Exception('Failed to login');
    }
  }
}
