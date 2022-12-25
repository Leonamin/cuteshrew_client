import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/community_preview_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/user_preview_data_mapper.dart';

class PostingPreviewDataMapper
    extends DataMapper<PostingEntity, PostingPreviewData> {
  @override
  PostingPreviewData map(PostingEntity object) {
    CommunityPreviewDataMapper communityMapper = CommunityPreviewDataMapper();
    UserPreviewDataMapper userMapper = UserPreviewDataMapper();

    // FIXME CommunityPreviewDataMapper랑 순환구조인 막장 매퍼
    return PostingPreviewData(
      postId: object.postId,
      title: object.title,
      isLocked: object.isLocked,
      publishedAt: object.publishedAt,
      updatedAt: object.updatedAt,
      writer: (object is PostingPreviewEntity)
          ? userMapper.map(object.writer)
          : null,
      ownCommunity: (object is PostingPreviewEntity)
          ? communityMapper.map(object.ownCommunity)
          : null,
      commentCount: object.commentCount,
    );
  }
}
