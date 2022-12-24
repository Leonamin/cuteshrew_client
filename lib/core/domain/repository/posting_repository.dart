import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class PostingRepository {
  // 게시글 가져오기
  Future<Either<Failure, PostingEntity>> getPosting({
    required String communityPath,
    required int postId,
    String? password,
  });

  // 페이지 단위로 게시글 가져오기
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingPage({
    required String communityPath,
    required int pageNum,
    required int loadCount,
  });

  // 유저 이름으로 게시글 가져오기
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingsByUser({
    required String userName,
    required int startAtId,
    required int loadCount,
  });

  // 게시글 생성하기
  Future<Either<Failure, void>> createPosting({
    required String communityPath,
    required PostingCreateEntity newPosting,
    required LoginTokenEntity loginToken,
  });

  // 게시글 업데이트
  Future<Either<Failure, void>> updatePosting({
    required String communityPath,
    required PostingCreateEntity newPosting,
    required int postId,
    required LoginTokenEntity loginToken,
  });

  // 게시글 삭제
  Future<Either<Failure, void>> deletePosting({
    required String communityPath,
    required int postId,
    required LoginTokenEntity loginToken,
  });
}
