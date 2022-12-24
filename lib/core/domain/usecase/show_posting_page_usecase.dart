import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/repository/comment_repository.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class ShowPostingPageUseCase {
  late PostingRepository postingRepository;
  late CommentRepository commentRepository;

  ShowPostingPageUseCase({required this.postingRepository});

  // 포스팅 정보를 가져온다.
  Future<Either<Failure, PostingEntity>> call(
    String communityName,
    int postId, [
    String? password,
  ]) {
    return postingRepository.getPosting(
      communityPath: communityName,
      postId: postId,
      password: password,
    );
  }

  // 댓글들을 가져온다.
  Future<Either<Failure, List<CommentEntity>>> loadComments(
    int postId,
    int pageNum,
    int commentCount, [
    String? password,
  ]) {
    return commentRepository.getCommentPage(
      postId: postId,
      pageNum: pageNum,
      commentCount: commentCount,
      password: password,
    );
  }

  // 포스팅을 삭제한다.
  Future<Either<Failure, void>> deletePosting(
    String communityName,
    int postId,
    LoginTokenEntity loginToken,
  ) {
    return postingRepository.deletePosting(
      communityPath: communityName,
      postId: postId,
      loginToken: loginToken,
    );
  }

  // 댓글을 삭제한다.
  Future<Either<Failure, void>> deleteComment(
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
