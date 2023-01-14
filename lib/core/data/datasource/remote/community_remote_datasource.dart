import 'dart:convert';
import 'package:cuteshrew/core/data/datasource/remote/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/http_constants.dart';
import 'package:cuteshrew/core/data/dto/remote/community_dto.dart';
import 'package:http/http.dart';

class CommunityRemoteDataSource extends CuteShrewRemoteDataSource {
  // 한개의 커뮤니티만 가져온다.
  Future<CommunityDTO> getCommunityPage(String communityName,
      [int pageNum = 1, int? loadCount]) async {
    try {
      // Response response = await get(HttpConstants.getCommunity(communityName));
      final Response response = await get(
          HttpConstants.getCommunityPage(communityName, pageNum, loadCount));
      if (response.statusCode != 200) {
        throw Exception();
      }
      return CommunityDTO.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  // 정확한 개수를 안보내면 모든 커뮤니티 가져온다.
  Future<List<CommunityDTO>> getCommunities([int? loadCommunityCount]) async {
    try {
      final Response response =
          await get(HttpConstants.getCommunities(loadCommunityCount));
      if (response.statusCode != 200) {
        throw Exception();
      }
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommunityDTO.fromJson(e)
      ];
    } catch (e) {
      rethrow;
    }
  }

  Future<List<CommunityDTO>> getMainCommunities() async {
    try {
      final Response response = await get(HttpConstants.getMainPage);
      if (response.statusCode != 200) {
        throw Exception();
      }
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommunityDTO.fromJson(e)
      ];
    } catch (e) {
      rethrow;
    }
  }

  Future<CommunityDTO> getCommunityInfo(String communityName,
      [int pageNum = 1, int? loadCount]) async {
    try {
      final Response response =
          await get(HttpConstants.getCommunityInfo(communityName));
      if (response.statusCode != 200) {
        throw Exception();
      }
      return CommunityDTO.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }
}
