import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

// 댓글 전문을 필요로 하는 곳에 사용하는 엔티티
class CommentEntity extends Equatable {
  final int commentId;
  final int writerId;
  final String comment;
  final int createdAt;
  final int postId;
  final int commentClass;
  final int order;
  final int groupId;
  final UserEntity writer;

  const CommentEntity({
    required this.commentId,
    required this.comment,
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
        comment,
        writerId,
        commentClass,
        createdAt,
        groupId,
        order,
        postId,
        writer,
      ];
}
