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
  // userName은 필수
  // startAtId는 순서에 따라 (지금은 순서를 정하는게 없으니 최신순) 지정 아이디부터 혹은 순서 처음부터(지금은 가장 최신부터)
  // loadCount는 한번에 가져올 때 얼마나 가져올지 정하기
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingsByUser({
    required String userName,
    int? startAtId,
    int? loadCount,
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
