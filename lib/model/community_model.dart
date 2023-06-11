import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/model/dto/community_dto.dart';

abstract class CommunityModel {
  Future<NetworkResult<CommunityInfo>> getCommunity(int communityId);
  Future<NetworkResult<List<CommunityInfo>>> getCommunityList(
    int loadCount, [
    int? startOffset,
  ]);
  Future<NetworkResult<List<CommunityInfo>>> getPopularCommunityList();
}
