import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/old/states/community_page_state.dart';
import 'package:flutter/widgets.dart';

class CommunityPageNotifier extends ValueNotifier<CommunityPageState> {
  CommunityPageNotifier({
    required this.api,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(CommunityPageState.notLoaded(
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage));
  final CuteshrewApiClient api;
  Community get communityInfo => value.communityInfo;
  int get currentPageNum => value.currentPageNum;
  int get countPerPage => value.countPerPage;

  // UI -> n번 페이지 요청 -> n번 페이지로 변수 변경 및 요청
  Future<void> getCommunityInfo(int currentPageNum,
      [int countPerPage = 25]) async {
    if (value is! LoadingCommunityPageState) {
      value = CommunityPageState.loading(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage);
      try {
        final result = await api.getCommunity(
            communityInfo.communityName, currentPageNum, countPerPage);
        if (result != null) {
          value = CommunityPageState.loadedData(
              communityInfo: result,
              currentPageNum: currentPageNum,
              countPerPage: countPerPage);
        } else {
          value = CommunityPageState.noData(
              communityInfo: communityInfo,
              currentPageNum: currentPageNum,
              countPerPage: countPerPage);
        }
      } catch (error) {
        value = CommunityPageState.notLoaded(
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
        print(error);
      }
    }
  }
}
