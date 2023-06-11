part of '../community_dto.dart';

class CommunityInfo extends _BaseCommunity {
  const CommunityInfo({
    required String communityName,
    required String communityShowName,
    required int postingCount,
  }) : super(
            communityName: communityName,
            communityShowName: communityShowName,
            postingCount: postingCount);
}
