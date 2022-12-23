import 'package:cuteshrew/core/domain/entity/comment_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/repository/comment_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class CreateCommentUseCase {
  late CommentRepository commentRepository;

  CreateCommentUseCase({required this.commentRepository});

  // 댓글 생성
  Future<Either<Failure, void>> createComment(
    int postId,
    CommentCreateEntity newComment,
    LoginTokenEntity loginToken,
  ) {
    return commentRepository.createComment(
        postId: postId, newComment: newComment, loginToken: loginToken);
  }

  // 답글 생성
  Future<Either<Failure, void>> createReply(
    int postId,
    int groupId,
    int commentClass,
    CommentCreateEntity newComment,
    LoginTokenEntity loginToken,
  ) {
    return commentRepository.createReply(
      postId: postId,
      groupId: groupId,
      commentClass: commentClass,
      newComment: newComment,
      loginToken: loginToken,
    );
  }
}
