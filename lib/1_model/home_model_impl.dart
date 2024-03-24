import 'package:cuteshrew/1_model/entity/community/community_summary.dart';
import 'package:cuteshrew/1_model/entity/posting/posting_summary.dart';
import 'package:cuteshrew/1_model/home_model.dart';
import 'package:cuteshrew/2_data/api_cuteshrew.dart';
import 'package:cuteshrew/2_data/async_result.dart';
import 'package:cuteshrew/2_data/remote/posting/posting_summary_res.dart';

class HomeModelImpl extends HomeModel {
  final ApiCuteShrew _apiCuteShrew;

  HomeModelImpl(
    this._apiCuteShrew,
  );

  @override
  Future<AsyncResult<List<CommunitySummary>>> getMainCommunityList() =>
      handleRequest(() async {
        return <CommunitySummary>[];
      });

  @override
  Future<AsyncResult<List<PostingSummary>>> getLatestPostingList() =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getLatestPostings();
        return result.map((e) => e.toEntity()).toList();
      });
}
