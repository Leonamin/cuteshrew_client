import 'community_entity.dart';

// 커뮤티니 정보가 있는 엔티티
class CommunityPreviewEntity extends CommunityEntity {
  const CommunityPreviewEntity({
    required super.communityName,
    required super.communityShowName,
    required super.postingCount,
  });
}
