import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';

// 댓글 전문을 필요로 하는 곳에 사용하는 엔티티
// 2022-12-25
// 다른 댓글 엔티티는 영향받지 않게 여기서만 UserEntity의 영향을 받게 수정한다.
class CommentDetailEntity extends CommentEntity {
  final String comment;
  final PostingEntity parentPosting;
  final UserEntity writer;

  const CommentDetailEntity({
    required int commentId,
    required this.comment,
    required int writerId,
    required int commentClass,
    required int createdAt,
    required int groupId,
    required int order,
    required int postId,
    required this.parentPosting,
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
        comment,
        writerId,
        commentClass,
        createdAt,
        groupId,
        order,
        postId,
        parentPosting,
        writer,
      ];
}
