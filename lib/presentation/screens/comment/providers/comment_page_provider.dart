import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/usecase/delete_comment_usecase.dart';
import 'package:cuteshrew/core/domain/usecase/show_posting_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/presentation/config/route/url_query_parameters.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_state.dart';
import 'package:flutter/cupertino.dart';

class CommentPageProvider extends ValueNotifier<CommentPageState> {
  final NavigationService _navigationService = locator<NavigationService>();

  CommentPageProvider({
    required ShowPostingPageUseCase postingPageUseCase,
    required DeleteCommentUseCase deleteCommentUseCase,
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
    _deleteCommentUseCase = deleteCommentUseCase;
  }

  late ShowPostingPageUseCase _postingPageUseCase;
  late DeleteCommentUseCase _deleteCommentUseCase;

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

  Future<bool> deleteComment(
    int postId,
    int commentId,
    LoginTokenEntity loginToken, [
    String? password,
  ]) async {
    final result =
        await _deleteCommentUseCase(postId, commentId, loginToken, password);
    return result.fold((Failure failure) {
      return false;
    }, (data) {
      return true;
    });
  }

  void navigateToUser(String userName) {
    _navigationService.navigateTo(Routes.UserPageRoute,
        queryParams: {UrlQueryParameters.userName: userName});
  }
}
