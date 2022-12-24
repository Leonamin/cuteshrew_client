import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

// 댓글 내용 없이 메타 데이터만 필요로 하는 엔티티
class CommentPreviewEntity extends Equatable {
  final int commentId;
  final int writerId;
  final int createdAt;
  final int postId;
  final int commentClass;
  final int order;
  final int groupId;
  final UserEntity writer;

  const CommentPreviewEntity({
    required this.commentId,
    required this.writerId,
    required this.commentClass,
    required this.createdAt,
    required this.groupId,
    required this.order,
    required this.postId,
    required this.writer,
  });
  @override
  List<Object?> get props => [
        commentId,
        writerId,
        commentClass,
        createdAt,
        groupId,
        order,
        postId,
        writer,
      ];
}
