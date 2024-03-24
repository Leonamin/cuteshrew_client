import 'package:cuteshrew/1_model/entity/community/community_summary.dart';
import 'package:cuteshrew/1_model/entity/posting/posting_summary.dart';
import 'package:cuteshrew/2_data/async_result.dart';

abstract class HomeModel {
  /// 커뮤니티 목록 가져오기
  Future<AsyncResult<List<CommunitySummary>>> getMainCommunityList();

  /// 최신 게시글 목록 가져오기
  Future<AsyncResult<List<PostingSummary>>> getLatestPostingList();
}
