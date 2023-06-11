import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/model/dto/comment_dto.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';

abstract class CommentModel {
  Future<NetworkResult<CommentDetailInfo>> getComment({
    required int postId,
    required int commentId,
    String? password,
  });

  // 페이지 별로 받는다
  Future<NetworkResult<List<CommentDetailInfo>>> getCommentPage({
    required int postId,
    required int pageNum,
    required int commentCount,
    String? password,
  });

  // 유저 아이디로 댓글 가져오기
  // userId는 필수
  // startAtId는 순서에 따라 (지금은 순서를 정하는게 없으니 최신순) 지정 아이디부터 혹은 순서 처음부터(지금은 가장 최신부터)
  // loadCount는 한번에 가져올 때 얼마나 가져올지 정하기
  Future<NetworkResult<List<CommentDetailInfo>>> getCommentsByUser({
    required int userId,
    int? startOffset,
    int? loadCount,
  });

  // 댓글 생성 분기
  Future<NetworkResult<void>> createComment({
    required int postId,
    required CommentCreateForm newComment,
    String? password,
    required LoginToken loginToken,
  });

  // 답글 생성 분기
  Future<NetworkResult<void>> createReply({
    required int postId,
    required int groupId,
    required int commentClass,
    required CommentCreateForm newComment,
    String? password,
    required LoginToken loginToken,
  });

  // 댓글, 답글 공통 수정
  Future<NetworkResult<void>> updateComment({
    required int postId,
    required int commentId,
    required CommentCreateForm newComment,
    String? password,
    required LoginToken loginToken,
  });

  // 댓글, 답글 공통 삭제
  Future<NetworkResult<void>> deleteComment({
    required int postId,
    required int commentId,
    String? password,
    required LoginToken loginToken,
  });
}
