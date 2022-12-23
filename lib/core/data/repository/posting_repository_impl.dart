import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class PostingRepositoryImpl extends PostingRepository {
  @override
  Future<Either<Failure, void>> createPosting(
      {required String communityPath,
      required PostingCreateEntity newPosting,
      required LoginTokenEntity loginToken}) {
    // TODO: implement createPosting
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deletePosting(
      {required String communityPath,
      required int postId,
      required LoginTokenEntity loginToken}) {
    // TODO: implement deletePosting
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, PostingEntity>> getPosting(
      {required String communityPath, required int postId, String? password}) {
    // TODO: implement getPosting
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingPage(
      {required String communityPath,
      required int pageNum,
      required int loadCount}) {
    // TODO: implement getPostingPage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingsByUser(
      {required String userName,
      required int startAtId,
      required int loadCount}) {
    // TODO: implement getPostingsByUser
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePosting(
      {required String communityPath,
      required PostingCreateEntity newPosting,
      required int postId,
      required LoginTokenEntity loginToken}) {
    // TODO: implement updatePosting
    throw UnimplementedError();
  }
}
