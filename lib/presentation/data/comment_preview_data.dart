// 댓글 내용 없이 기본정보와 유저 정보만 필요로 하는 프레젠테이션 계층 모델
// \최소 정보 + 유저 정보만 받게 수정
import 'package:cuteshrew/presentation/data/comment_data.dart';
import 'package:cuteshrew/presentation/data/user_data.dart';

class CommentPreviewData extends CommentData {
  final UserData writer;

  const CommentPreviewData({
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
        writer,
      ];
}
