import 'package:cuteshrew/core/domain/entity/comment_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CommentRepository {
  // 잠긴 게시물일 수 있으니까 password 포함
  Future<Either<Failure, CommentEntity>> getComment({
    required int postId,
    required int commentId,
    String? password,
  });

  // 페이지 별로 받는다
  Future<Either<Failure, List<CommentEntity>>> getCommentPage({
    required int postId,
    required int pageNum,
    required int commentCount,
    String? password,
  });

  // 댓글 생성 분기
  Future<Either<Failure, void>> createComment({
    required int postId,
    required CommentCreateEntity newComment,
    String? password,
    required LoginTokenEntity loginToken,
  });

  // 답글 생성 분기
  Future<Either<Failure, void>> createReply({
    required int postId,
    required int groupId,
    required CommentCreateEntity newComment,
    String? password,
    required LoginTokenEntity loginToken,
  });

  // 댓글, 답글 공통 수정
  Future<Either<Failure, void>> updateComment({
    required int postId,
    required int commentId,
    required CommentCreateEntity newComment,
    String? password,
    required LoginTokenEntity loginToken,
  });

  // 댓글, 답글 공통 삭제
  Future<Either<Failure, void>> deleteComment({
    required int postId,
    required int commentId,
    String? password,
    required LoginTokenEntity loginToken,
  });
}
