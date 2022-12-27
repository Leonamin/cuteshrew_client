import 'package:cuteshrew/core/domain/entity/comment_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/data/community_preview_data.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/data/user_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/posting_preview_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/user_preview_data_mapper.dart';

class CommentDetailDataMapper
    extends DataMapper<CommentEntity, CommentDetailData> {
  @override
  CommentDetailData map(CommentEntity object) {
    PostingPreviewDataMapper postingMapper = PostingPreviewDataMapper();
    UserPreviewDataMapper userMapper = UserPreviewDataMapper();

    return CommentDetailData(
      commentId: object.commentId,
      comment: (object is CommentDetailEntity) ? object.comment : "",
      writerId: object.writerId,
      commentClass: object.commentClass,
      createdAt: object.createdAt,
      groupId: object.groupId,
      order: object.order,
      postId: object.postId,
      parentPosting: (object is CommentDetailEntity)
          ? postingMapper.map(object.parentPosting)
          : const PostingPreviewData(
              postId: 1,
              title: "",
              commentCount: 0,
              isLocked: false,
              publishedAt: 0,
              updatedAt: 0,
              writer: UserPreviewData(
                name: "unknown",
                email: "",
              ),
              ownCommunity: CommunityPreviewData(
                communityName: "None",
                communityShowName: "None",
                postingCount: 0,
                postings: [],
              ),
            ),
      writer: (object is CommentDetailEntity)
          ? userMapper.map(object.writer)
          : UserPreviewData(name: "unknown", email: "unknown"),
    );
  }
}
