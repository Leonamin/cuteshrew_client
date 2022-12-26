import 'package:cuteshrew/core/domain/entity/comment_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/data/user_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/user_preview_data_mapper.dart';

class CommentDetailDataMapper
    extends DataMapper<CommentEntity, CommentDetailData> {
  @override
  CommentDetailData map(CommentEntity object) {
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
      writer: (object is CommentDetailEntity)
          ? userMapper.map(object.writer)
          : UserPreviewData(name: "unknown", email: "unknown"),
    );
  }
}
