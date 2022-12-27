import 'package:cuteshrew/core/domain/usecase/show_posting_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_state.dart';
import 'package:flutter/cupertino.dart';

class CommentPageProvider extends ValueNotifier<CommentPageState> {
  CommentPageProvider({
    required ShowPostingPageUseCase postingPageUseCase,
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(CommentPageState.noData(
            postId: postId,
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage)) {
    _postingPageUseCase = postingPageUseCase;
  }

  late ShowPostingPageUseCase _postingPageUseCase;

  int get postId => value.postId;
  String get communityName => value.communityName;
  int get currentPageNum => value.currentPageNum;
  int get countPerPage => value.countPerPage;

  // UI -> n번 페이지 요청 -> n번 페이지로 변수 변경 및 요청
  Future<void> getCommentPage(int currentPageNum) async {
    if (value is! LoadingCommentPageState) {
      value = CommentPageState.loading(
        postId: postId,
        communityName: communityName,
        currentPageNum: currentPageNum,
        countPerPage: countPerPage,
      );

      final result = await _postingPageUseCase.loadComments(
        // TODO 댓글 기능 정상화할 때 복구
        // communityName,
        postId,
        currentPageNum,
        countPerPage,
      );

      result.fold((Failure failure) {
        value = CommentPageState.noData(
          postId: postId,
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
      }, (data) {
        value = CommentPageState.loadedData(
          communityName: communityName,
          postId: postId,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
          commentEntityList: data,
        );
      });
    }
  }
}
