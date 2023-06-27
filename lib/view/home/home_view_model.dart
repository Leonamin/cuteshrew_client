import 'package:cuteshrew/common/logger.dart';
import 'package:cuteshrew/model/community_model.dart';
import 'package:cuteshrew/model/dto/community_dto.dart';
import 'package:cuteshrew/model/dto/posting_dto.dart';
import 'package:cuteshrew/model/posting_model.dart';
import 'package:cuteshrew/view/common/base_view_model.dart';
import 'package:flutter/widgets.dart';

class HomeViewModel extends BaseViewModel {
  HomeViewModel(this._communityModel, this._postingModel);
  final CommunityModel _communityModel;
  final PostingModel _postingModel;

  final List<CommunityInfo> _communityInfoList = [];
  List<CommunityInfo> get communityInfoList => _communityInfoList;

  final Map<String, List<PostingSummaryInfo>> _postingSummaryInfoMap = {};

  @override
  onInit() {
    _getCommunities();
  }

  @override
  onClose() {}

  Future<void> _getCommunities() async {
    final result = await _communityModel.getPopularCommunityList();
    result
      ..onFailure((e) {
        logger.e(e.toString());
        notifyListeners();
      })
      ..onSuccess((data) {
        _handleFetchCommunities();
      });
  }

  Future<void> _getPostingFromCommunity(String communityName) async {
    final result = await _postingModel.getPostingPage(communityName, 1);
    result
      ..onFailure((e) {
        logger.e(e.toString());
        notifyListeners();
      })
      ..onSuccess((data) {
        _postingSummaryInfoMap[communityName] = data;
        notifyListeners();
      });
  }

  Future<void> _handleFetchCommunities() async {
    for (final communityInfo in _communityInfoList) {
      await _getPostingFromCommunity(communityInfo.communityName);
    }
  }

  void navigateToCommunity(BuildContext context) {}
  void navigateToPosting(BuildContext context) {}
  void navigateToUser(BuildContext context) {}

  void onTapCommunity() {}
  void onTapPosting() {}
  void onTapUser() {}
}
