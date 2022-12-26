import 'package:cuteshrew/presentation/data/comment_data.dart';
import 'package:cuteshrew/presentation/data/user_data.dart';

// 댓글 전문을 필요로 하는 곳에 사용하는 프레젠테이션 모델
// 다른 댓글 모델은 영향받지 않게 여기서만 UserData의 영향을 받게 수정한다.
class CommentDetailData extends CommentData {
  final String comment;
  final UserData writer;

  const CommentDetailData({
    required int commentId,
    required this.comment,
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
  List<Object?> get props =>
      super.props +
      [
        comment,
        writer,
      ];
}
