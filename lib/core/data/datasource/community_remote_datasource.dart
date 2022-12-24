import 'dart:convert';

import 'package:cuteshrew/core/data/datasource/cuteshrew_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/http_constants.dart';
import 'package:cuteshrew/core/data/dto/community_dto.dart';
import 'package:http/http.dart';

class CommunityRemoteDataSource extends CuteShrewRemoteDataSource {
  // 한개의 커뮤니티만 가져온다.
  Future<CommunityDTO> getCommunity(String communityName) async {
    final url = super
        .urlCreate(endpoint: HttpConstants.endpointCommunity + communityName);

    try {
      Response response = await get(url);
      return CommunityDTO.fromJson(
          json.decode(utf8.decode(response.bodyBytes)));
    } catch (e) {
      rethrow;
    }
  }

  // 정확한 개수를 안보내면 모든 커뮤니티 가져온다.
  Future<List<CommunityDTO>> getCommunities([int? loadCommunityCount]) async {
    final Map<String, dynamic> params = {
      if (loadCommunityCount != null)
        HttpConstants.queryCommunityCount: loadCommunityCount.toString(),
    };

    final url = super.urlCreate(
        endpoint: HttpConstants.endpointCommunity, queryParams: params);

    try {
      Response response = await get(url);
      return [
        for (final e in json.decode(utf8.decode(response.bodyBytes)))
          CommunityDTO.fromJson(e)
      ];
    } catch (e) {
      rethrow;
    }
  }
}
