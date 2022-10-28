import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/states/comment_page_state.dart';
import 'package:flutter/cupertino.dart';

class CommentPageNotifier extends ValueNotifier<CommentPageState> {
  CommentPageNotifier({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required this.api,
  }) : super(CommentPageState.noData(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage));

  final CuteshrewApiClient api;

  int get postId => value.postId;
  Community get communityInfo => value.communityInfo;
  int get currentPageNum => value.currentPageNum;
  int get countPerPage => value.countPerPage;

  // UI -> n번 페이지 요청 -> n번 페이지로 변수 변경 및 요청
  Future<void> getCommentPage(int currentPageNum,
      [int countPerPage = 50]) async {
    if (value is! LoadingCommentPageState) {
      value = CommentPageState.loading(
          postId: postId,
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage);
      try {
        final result = await api.getCommentPage(
            communityInfo.communityName, postId, currentPageNum, countPerPage);
        if (result != null) {
          value = CommentPageState.loadedData(
            communityInfo: communityInfo,
            postId: postId,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage,
            comments: result,
          );
        } else {
          value = CommentPageState.noData(
              postId: postId,
              communityInfo: communityInfo,
              currentPageNum: currentPageNum,
              countPerPage: countPerPage);
        }
      } catch (error) {
        value = CommentPageState.notLoaded(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
        print(error);
      }
    }
  }
}
