import 'package:cuteshrew/core/domain/entity/community_preview_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_community_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/screens/community/providers/community_page_state.dart';
import 'package:flutter/widgets.dart';

class CommunityPageProvider extends ValueNotifier<CommunityPageState> {
  CommunityPageProvider({
    required ShowCommunityPageUseCase communityPageUseCase,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(CommunityPageState.notLoaded(
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage)) {
    _communityPageUseCase = communityPageUseCase;
  }
  late ShowCommunityPageUseCase _communityPageUseCase;

  String get communityName => value.communityName;
  int get currentPageNum => value.currentPageNum;
  int get countPerPage => value.countPerPage;

  // UI -> n번 페이지 요청 -> n번 페이지로 변수 변경 및 요청
  Future<void> getCommunityInfo(int currentPageNum,
      [int countPerPage = 25]) async {
    if (value is! LoadingCommunityPageState) {
      final result = await _communityPageUseCase(communityName);

      // 이중 비동기 지옥
      result.fold((Failure failure) {
        value = CommunityPageState.notLoaded(
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
      }, (data) async {
        final postingResult = await _communityPageUseCase.loadPage(
            communityName, currentPageNum, countPerPage);

        postingResult.fold((Failure failure) {
          value = CommunityPageState.notLoaded(
              communityName: communityName,
              currentPageNum: currentPageNum,
              countPerPage: countPerPage);
        }, (adata) {
          value = CommunityPageState.loadedData(
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage,
            communityEntity: data,
            postingEntityList: (data is CommunityPreviewEntity) ? adata : [],
          );
        });
      });
    }
  }
}
