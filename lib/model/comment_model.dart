import 'package:cuteshrew/data/hive/hive_helper.dart';
import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/data/remote/api_cuteshrew.dart';
import 'package:cuteshrew/data/remote/comment/comment_req.dart';
import 'package:cuteshrew/data/remote/comment/comment_res.dart';
import 'package:cuteshrew/model/dto/comment_dto.dart';

class CommentModel {
  final ApiCuteShrew _apiCuteShrew = ApiCuteShrew();
  final HiveHelper _hiveHelper = HiveHelper();

  Future<NetworkResult<List<CommentDetailInfo>>> getCommentList(
    int postId,
    int commentId, [
    int? loadCount,
  ]) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getCommentList(
            postId, commentId, loadCount ?? 10);
        return result.map((e) => e.toDetailInfo()).toList();
      });

  Future<NetworkResult<List<CommentSummaryInfo>>> getCommentListAboutUser(
    String userName,
    int startToOffset, [
    int? loadCount,
  ]) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.searchComments(
            userName, startToOffset, loadCount ?? 10);
        return result.map((e) => e.toSummaryInfo()).toList();
      });

  Future<NetworkResult<void>> createComment(
    int postId,
    CommentCreateForm newComment,
  ) =>
      handleRequest(() async {
        return await _apiCuteShrew.uploadComment(
          postId,
          _hiveHelper.loginToken,
          CommentReq(
            comment: newComment.comment,
          ),
        );
      });

  Future<NetworkResult<void>> updateComment(
    int commentId,
    CommentCreateForm newComment,
  ) =>
      handleRequest(() async {
        return await _apiCuteShrew.updateComment(
          commentId,
          _hiveHelper.loginToken,
          CommentReq(
            comment: newComment.comment,
          ),
        );
      });

  Future<NetworkResult<void>> deleteComment(
    int commentId,
  ) =>
      handleRequest(() async {
        return await _apiCuteShrew.deleteComment(
          commentId,
          _hiveHelper.loginToken,
        );
      });
}
