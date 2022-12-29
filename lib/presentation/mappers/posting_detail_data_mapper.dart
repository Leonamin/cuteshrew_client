import 'package:cuteshrew/core/domain/entity/posting_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/presentation/data/posting_detail_data.dart';
import 'package:cuteshrew/presentation/mappers/community_preview_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/user_preview_data_mapper.dart';

class PostingDetailDataMapper
    extends DataMapper<PostingEntity, PostingDetailData> {
  @override
  PostingDetailData map(PostingEntity object) {
    CommunityPreviewDataMapper communityMapper = CommunityPreviewDataMapper();
    UserPreviewDataMapper userMapper = UserPreviewDataMapper();

    // FIXME CommunityDataMapper랑 순환구조인 막장 매퍼
    return PostingDetailData(
      postId: object.postId,
      title: object.title,
      body: (object is PostingDetailEntity) ? object.body : "",
      isLocked: object.isLocked,
      publishedAt: object.publishedAt,
      updatedAt: object.updatedAt,
      writer: (object is PostingDetailEntity)
          ? userMapper.map(object.writer)
          : null,
      ownCommunity: (object is PostingDetailEntity)
          ? communityMapper.map(object.ownCommunity)
          : null,
      commentCount: object.commentCount,
    );
  }
}
