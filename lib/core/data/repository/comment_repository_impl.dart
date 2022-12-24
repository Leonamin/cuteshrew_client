import 'package:cuteshrew/core/data/datasource/remote/comment_remote_datasource.dart';
import 'package:cuteshrew/core/data/dto/comment_dto.dart';
import 'package:cuteshrew/core/data/mapper/comment_create_mapper.dart';
import 'package:cuteshrew/core/data/mapper/comment_mapper.dart';
import 'package:cuteshrew/core/data/mapper/comment_preview_mapper.dart';
import 'package:cuteshrew/core/data/mapper/login_token_mapper.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_preview_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_create_entity.dart';
import 'package:cuteshrew/core/domain/repository/comment_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:cuteshrew/core/resources/failure.dart';

class CommentRepositoryImpl extends CommentRepository {
  late CommentRemoteDataSource _commentRemoteDataSource;

  CommentRepositoryImpl(
      {required CommentRemoteDataSource commentRemoteDatasource}) {
    _commentRemoteDataSource = commentRemoteDatasource;
  }

  /**
   * FIXME 서버에서 커뮤니티 이름 없이 가져오는걸로 수정되기 전까지는 댓글 메소드 동작 안함
   */
  @override
  Future<Either<Failure, void>> createComment(
      {required int postId,
      required CommentCreateEntity newComment,
      String? password,
      required LoginTokenEntity loginToken}) async {
    try {
      CommentCreateMapper commentMapper = CommentCreateMapper();
      LoginTokenMapper tokenMapper = LoginTokenMapper();

      return Right(_commentRemoteDataSource.uploadComment(
        "",
        postId,
        tokenMapper.toDTO(loginToken),
        commentMapper.map(newComment),
      ));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> createReply(
      {required int postId,
      required int groupId,
      required int commentClass,
      required CommentCreateEntity newComment,
      String? password,
      required LoginTokenEntity loginToken}) async {
    // TODO: implement createReply
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> deleteComment(
      {required int postId,
      required int commentId,
      String? password,
      required LoginTokenEntity loginToken}) async {
    try {
      LoginTokenMapper tokenMapper = LoginTokenMapper();

      return Right(_commentRemoteDataSource.deleteComment(
        "",
        postId,
        commentId,
        tokenMapper.toDTO(loginToken),
      ));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  /**
   * TODO 단일로 댓글 가져오는 기능은 아직 안만든다.
   */
  @override
  Future<Either<Failure, CommentEntity>> getComment(
      {required int postId, required int commentId, String? password}) {
    // TODO: implement getCommentPage
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<CommentEntity>>> getCommentPage(
      {required int postId,
      required int pageNum,
      required int commentCount,
      String? password}) async {
    try {
      CommentMapper commentMapper = CommentMapper();
      List<CommentDTO> commentDTO = await _commentRemoteDataSource
          .getCommentPage("", postId, pageNum, commentCount);
      List<CommentEntity> result = [
        for (final e in commentDTO) commentMapper.map(e)
      ];
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<CommentPreviewEntity>>> getCommentsByUser(
      {required String userName,
      required int startAtId,
      required int loadCount}) async {
    try {
      CommentPreviewMapper mapper = CommentPreviewMapper();
      List<CommentDTO> commentDTO = await _commentRemoteDataSource
          .searchComments(userName, startAtId, loadCount);
      List<CommentPreviewEntity> result = [
        for (final e in commentDTO) mapper.map(e)
      ];
      return Right(result);
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateComment(
      {required int postId,
      required int commentId,
      required CommentCreateEntity newComment,
      String? password,
      required LoginTokenEntity loginToken}) async {
    try {
      CommentCreateMapper commentMapper = CommentCreateMapper();
      LoginTokenMapper tokenMapper = LoginTokenMapper();

      return Right(_commentRemoteDataSource.updateComment(
        "",
        postId,
        commentId,
        tokenMapper.toDTO(loginToken),
        commentMapper.map(newComment),
      ));
    } on Exception catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}
