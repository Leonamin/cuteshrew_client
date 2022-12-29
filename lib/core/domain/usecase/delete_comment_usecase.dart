import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/repository/comment_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class DeleteCommentUseCase {
  late CommentRepository commentRepository;

  DeleteCommentUseCase({required this.commentRepository});

  Future<Either<Failure, void>> call(
    int postId,
    int commentId,
    LoginTokenEntity loginToken, [
    String? password,
  ]) {
    return commentRepository.deleteComment(
      postId: postId,
      commentId: commentId,
      loginToken: loginToken,
      password: password,
    );
  }
}
