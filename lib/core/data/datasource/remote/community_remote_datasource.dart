import 'dart:convert';
import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/2_data/remote/community/community_summary_res.dart';
import 'package:http/http.dart';

class CommunityRemoteDataSource extends CuteShrewRemoteDataSource {
  // 한개의 커뮤니티만 가져온다.
  Future<CommunitySummaryRes> getCommunityPage(String communityName,
      [int pageNum = 1, int? loadCount]) async {
    try {
      // Response response = await get(HttpConstants.getCommunity(communityName));
      Response response = await get(
          HttpConstants.getCommunityPage(communityName, pageNum, loadCount));

      return CommunitySummaryRes.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  // 정확한 개수를 안보내면 모든 커뮤니티 가져온다.
  Future<List<CommunitySummaryRes>> getCommunities(
      [int? loadCommunityCount]) async {
    try {
      Response response =
          await get(HttpConstants.getCommunities(loadCommunityCount));
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommunitySummaryRes.fromJson(e)
      ];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommunitySummaryRes>> getMainCommunities() async {
    try {
      Response response = await get(HttpConstants.getMainPage);
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommunitySummaryRes.fromJson(e)
      ];
    } catch (e) {
      rethrow;
    }
  }
}
