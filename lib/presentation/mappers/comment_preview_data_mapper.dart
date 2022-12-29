import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_preview_entity.dart';
import 'package:cuteshrew/presentation/data/comment_preview_data.dart';
import 'package:cuteshrew/presentation/data/user_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/user_preview_data_mapper.dart';

class CommentPreviewDataMapper
    extends DataMapper<CommentEntity, CommentPreviewData> {
  @override
  CommentPreviewData map(CommentEntity object) {
    UserPreviewDataMapper userMapper = UserPreviewDataMapper();

    return CommentPreviewData(
      commentId: object.commentId,
      writerId: object.writerId,
      commentClass: object.commentClass,
      createdAt: object.createdAt,
      groupId: object.groupId,
      order: object.order,
      postId: object.postId,
      writer: (object is CommentPreviewEntity)
          ? userMapper.map(object.writer)
          : UserPreviewData(name: "unknown", email: "unknown"),
    );
  }
}
