import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/data/remote/api_cuteshrew.dart';
import 'package:cuteshrew/data/remote/community/community_res.dart';
import 'package:cuteshrew/model/dto/community_dto.dart';

class CommunityModel {
  final ApiCuteShrew _apiCuteShrew = ApiCuteShrew();

  Future<NetworkResult<CommunityInfo>> getCommunity(String communityName) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getCommunityInfo(communityName);
        return result.toCommunityInfo();
      });

  Future<NetworkResult<List<CommunityInfo>>> getCommunityList(
    int loadCount,
  ) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getCommunityList(loadCount);
        return result.map((e) => e.toCommunityInfo()).toList();
      });

  Future<NetworkResult<List<CommunityInfo>>> getPopularCommunityList() =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getMainCommunityList();
        return result.map((e) => e.toCommunityInfo()).toList();
      });
}
