import 'dart:convert';

import 'package:cuteshrew/model/Community.dart';
import 'package:http/http.dart';

class HttpService {
  final String baseUrl = "http://cuteshrew.xyz";
  // final String baseUrl = "http://127.0.0.1"; //debug
  final String communityUrl = "/community";

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
}
