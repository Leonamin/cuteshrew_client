import 'package:cuteshrew/1_model/entity/community/community_summary.dart';
import 'package:cuteshrew/1_model/entity/posting/posting_summary.dart';
import 'package:cuteshrew/1_model/home_model.dart';
import 'package:cuteshrew/1_model/home_model_impl.dart';
import 'package:cuteshrew/2_data/api_cuteshrew.dart';
import 'package:cuteshrew/3_view/0_component/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeViewModelProvider = ChangeNotifierProvider(
  (ref) => HomeViewModel(HomeModelImpl(ApiCuteShrew())),
);

class HomeViewModel extends BaseViewModel {
  final HomeModel _model;

  final List<CommunitySummary> mainCommunities = [];
  final List<PostingSummary> popularPostings = [];

  HomeViewModel(
    this._model,
  ) : super();

  @override
  void init() async {
    super.init();
    await fetchMainCommunities();
    await fetchLatestPostings();
    completeInit();
  }

  Future<void> fetchMainCommunities() async {
    final result = await _model.getMainCommunityList();
    result
      ..onFailure((e) => null)
      ..onSuccess((communities) {
        mainCommunities.clear();
        mainCommunities.addAll(communities);
      });
    notifyListeners();
  }

  // void _initTabController() {
  //   _tabController = TabController(
  //     length: mainCommunities.length + 1,
  //     vsync: this,
  //   );
  // }

  Future<void> fetchLatestPostings() async {
    final result = await _model.getLatestPostingList();
    result
      ..onFailure((e) {
        print(e);
      })
      ..onSuccess((postings) {
        popularPostings.clear();
        popularPostings.addAll(postings);
      });
    notifyListeners();
  }
}
