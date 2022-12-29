import 'package:cuteshrew/core/domain/entity/comment_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_preview_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:cuteshrew/core/domain/repository/comment_repository.dart';
import 'package:cuteshrew/core/domain/repository/posting_repository.dart';
import 'package:cuteshrew/core/domain/repository/user_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class ShowUserPageUsecase {
  late UserRepository userRepository;
  late PostingRepository postingRepository;
  late CommentRepository commentRepository;

  ShowUserPageUsecase({
    required this.userRepository,
    required this.postingRepository,
    required this.commentRepository,
  });

  // 유저 기본 정보를 가져온다.
  Future<Either<Failure, UserEntity>> call(String userName) {
    return userRepository.getUser(userName: userName);
  }

  // 유저의 게시글들을 가져온다.
  // userName은 필수
  // startAtId는 순서에 따라 (지금은 순서를 정하는게 없으니 최신순) 지정 아이디부터 혹은 순서 처음부터(지금은 가장 최신부터)
  // loadCount는 한번에 가져올 때 얼마나 가져올지 정하기
  Future<Either<Failure, List<PostingPreviewEntity>>> loadPostings(
    String userName, [
    int? startAtId,
    int? loadCount,
  ]) {
    return postingRepository.getPostingsByUser(
        userName: userName, startAtId: startAtId, loadCount: loadCount);
  }

  // 유저의 댓글들을 가져온다.

  Future<Either<Failure, List<CommentDetailEntity>>> loadComments(
    String userName, [
    int? startAtId,
    int? loadCount,
  ]) {
    return commentRepository.getCommentsByUser(
        userName: userName, startAtId: startAtId, loadCount: loadCount);
  }
}
