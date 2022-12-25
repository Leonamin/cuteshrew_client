import 'package:cuteshrew/core/domain/entity/posting_entity.dart';

import 'community_entity.dart';

// 커뮤티니 정보가 있는 엔티티
// 2022-12-25
// 미리보기 정보에 하위 게시물들도 보여주도록 처리
class CommunityPreviewEntity extends CommunityEntity {
  // 커뮤니티에 대표로 보여줄 게시글들
  final List<PostingEntity> postings;

  const CommunityPreviewEntity({
    required super.communityName,
    required super.communityShowName,
    required super.postingCount,
    required this.postings,
  });
}
