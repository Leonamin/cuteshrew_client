import 'package:cuteshrew/data/hive/hive_helper.dart';
import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/data/remote/api_cuteshrew.dart';
import 'package:cuteshrew/data/remote/posting/posting_req.dart';
import 'package:cuteshrew/data/remote/posting/posting_res.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:cuteshrew/model/dto/posting_dto.dart';

class PostingModel {
  final ApiCuteShrew _apiCuteShrew = ApiCuteShrew();
  final HiveHelper _hiveHelper = HiveHelper();

  Future<NetworkResult<PostingDetailInfo>> getPosting(
    String communityName,
    int postId, [
    String? password,
  ]) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getPosting(
          communityName,
          postId,
          password,
        );
        return result.toDetailInfo();
      });

  Future<NetworkResult<List<PostingSummaryInfo>>> getPostingPage(
    String communityName,
    int pageNum, [
    int? loadCount,
  ]) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getPostingSummaryList(
          communityName,
          pageNum,
          loadCount ?? 10,
        );
        return result.map((e) => e.toSummaryInfo()).toList();
      });

  Future<NetworkResult<List<PostingSummaryInfo>>> getPostingsByUser(
    String userName, [
    int? startOffset,
    int? loadCount,
  ]) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.searchPostings(
          userName,
          startOffset ?? 0,
          loadCount ?? 10,
        );
        return result.map((e) => e.toSummaryInfo()).toList();
      });

  Future<NetworkResult<void>> createPosting(
    String communityName,
    PostingCreateForm newPosting,
  ) =>
      handleRequest(() async {
        return await _apiCuteShrew.uploadPosting(
          communityName,
          _hiveHelper.loginToken,
          PostingReq(
            title: newPosting.title,
            body: newPosting.body,
            isLocked: newPosting.isLocked,
            password: newPosting.password,
          ),
        );
      });

  Future<NetworkResult<void>> updatePosting(
    String communityName,
    int postId,
    PostingCreateForm newPosting,
    LoginToken loginToken,
  ) =>
      handleRequest(() async {
        return await _apiCuteShrew.updatePosting(
          communityName,
          postId,
          _hiveHelper.loginToken,
          PostingReq(
            title: newPosting.title,
            body: newPosting.body,
            isLocked: newPosting.isLocked,
            password: newPosting.password,
          ),
        );
      });

  Future<NetworkResult<void>> deletePosting(
    int communityName,
    int postId,
  ) =>
      handleRequest(() async {
        return await _apiCuteShrew.deleteComment(
          communityName,
          _hiveHelper.loginToken,
        );
      });
}
