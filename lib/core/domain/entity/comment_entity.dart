import 'package:equatable/equatable.dart';

// 댓글이 가진 최소 정보만 정의한다.
// 2022-12-25
// UserEntity에 영향을 받지 않도록 Detail과 Preivew 분리
abstract class CommentEntity extends Equatable {
  final int commentId;
  final int writerId;
  final int createdAt;
  final int postId;
  final int commentClass;
  final int order;
  final int groupId;

  const CommentEntity({
    required this.commentId,
    required this.writerId,
    required this.commentClass,
    required this.createdAt,
    required this.groupId,
    required this.order,
    required this.postId,
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
      ];
}
