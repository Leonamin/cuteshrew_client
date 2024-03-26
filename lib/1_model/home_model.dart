import 'package:cuteshrew/1_model/entity/community/community_summary.dart';
import 'package:cuteshrew/1_model/entity/posting/posting_summary.dart';
import 'package:cuteshrew/1_model/home_model_impl.dart';
import 'package:cuteshrew/2_data/api_cuteshrew.dart';
import 'package:cuteshrew/2_data/async_result.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeModelProvider =
    Provider<HomeModel>((ref) => HomeModelImpl(ref.read(apiCuteShrewProvider)));

abstract class HomeModel {
  /// 커뮤니티 목록 가져오기
  Future<AsyncResult<List<CommunitySummary>>> getMainCommunityList();

  /// 최신 게시글 목록 가져오기
  Future<AsyncResult<List<PostingSummary>>> getLatestPostingList();
}
