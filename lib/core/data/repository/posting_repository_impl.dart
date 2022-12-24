import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/dto/posting_dto.dart';
import 'package:cuteshrew/core/data/mapper/login_token_mapper.dart';
import 'package:cuteshrew/core/data/mapper/posting_create_mapper.dart';
import 'package:cuteshrew/core/data/mapper/posting_mapper.dart';
import 'package:cuteshrew/core/data/mapper/posting_preview_mapper.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_create_entity.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class PostingRepositoryImpl extends PostingRepository {
  late PostingRemoteDataSource _postingRemoteDataSource;

  PostingRepositoryImpl(
      {required PostingRemoteDataSource postingRemoteDataSource}) {
    _postingRemoteDataSource = postingRemoteDataSource;
  }

  @override
  Future<Either<Failure, void>> createPosting({
    required String communityPath,
    required PostingCreateEntity newPosting,
    required LoginTokenEntity loginToken,
  }) async {
    try {
      PostingCreateMapper postingMapper = PostingCreateMapper();
      LoginTokenMapper tokenMapper = LoginTokenMapper();

      return Right(_postingRemoteDataSource.uploadPosting(communityPath,
          tokenMapper.toDTO(loginToken), postingMapper.map(newPosting)));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deletePosting({
    required String communityPath,
    required int postId,
    required LoginTokenEntity loginToken,
  }) async {
    try {
      LoginTokenMapper tokenMapper = LoginTokenMapper();

      return Right(_postingRemoteDataSource.deletePosting(
          communityPath, postId, tokenMapper.toDTO(loginToken)));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostingEntity>> getPosting({
    required String communityPath,
    required int postId,
    String? password,
  }) async {
    try {
      PostingDTO postingDTO = await _postingRemoteDataSource.getPosting(
          communityPath, postId, password);
      PostingMapper mapper = PostingMapper();
      PostingEntity result = mapper.map(postingDTO);
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingPage({
    required String communityPath,
    required int pageNum,
    required int loadCount,
  }) async {
    try {
      List<PostingDTO> postingDTOList = await _postingRemoteDataSource
          .getPostings(communityPath, pageNum, loadCount);
      PostingPreviewMapper mapper = PostingPreviewMapper();
      List<PostingPreviewEntity> result = [
        for (final e in postingDTOList) mapper.map(e)
      ];
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<PostingPreviewEntity>>> getPostingsByUser(
      {required String userName,
      required int startAtId,
      required int loadCount}) async {
    try {
      List<PostingDTO> postingDTOList = await _postingRemoteDataSource
          .searchPostings(userName, startAtId, loadCount);
      PostingPreviewMapper mapper = PostingPreviewMapper();
      List<PostingPreviewEntity> result = [
        for (final e in postingDTOList) mapper.map(e)
      ];
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updatePosting(
      {required String communityPath,
      required PostingCreateEntity newPosting,
      required int postId,
      required LoginTokenEntity loginToken}) async {
    try {
      PostingCreateMapper postingMapper = PostingCreateMapper();
      LoginTokenMapper tokenMapper = LoginTokenMapper();

      return Right(_postingRemoteDataSource.updatePosting(communityPath, postId,
          tokenMapper.toDTO(loginToken), postingMapper.map(newPosting)));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
