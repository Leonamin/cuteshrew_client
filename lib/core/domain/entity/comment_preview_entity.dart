import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 댓글 내용 없이 기본정보와 유저 정보만 필요로 하는 엔티티
// 2022-12-25
// 댓글 엔티티 내용 분리하여 최소 정보 + 유저 정보만 받게 수정
class CommentPreviewEntity extends CommentEntity {
  final UserEntity writer;

  const CommentPreviewEntity({
    required int commentId,
    required int writerId,
    required int commentClass,
    required int createdAt,
    required int groupId,
    required int order,
    required int postId,
    required this.writer,
  }) : super(
          commentId: commentId,
          writerId: writerId,
          commentClass: commentClass,
          createdAt: createdAt,
          groupId: groupId,
          order: order,
          postId: postId,
        );
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
