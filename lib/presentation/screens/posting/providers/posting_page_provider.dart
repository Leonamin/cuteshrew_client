import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_posting_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/screens/posting/providers/posting_page_state.dart';
import 'package:flutter/widgets.dart';

class PostingPageProvider extends ValueNotifier<PostingPageState> {
  late ShowPostingPageUseCase _postingPageUseCase;

  PostingPageProvider({
    required int postId,
    required String communityName,
    required ShowPostingPageUseCase postingPageUseCase,
  }) : super(PostingPageState.notLoaded(
            postId: postId, communityName: communityName)) {
    _postingPageUseCase = postingPageUseCase;
  }
  int get postId => value.postId;
  String get communityName => value.communityName;

  Future<void> getPosting([String? password]) async {
    if (value is! LoadingPostingPageState) {
      value = PostingPageState.loading(
          postId: postId, communityName: communityName);

      final result = await _postingPageUseCase(communityName, postId, password);

      result.fold((Failure failure) {
        //TODO 여기서 좀 작업 하자
        // 비밀번호
        value = PostingPageState.needPassword(
          postId: postId,
          communityName: communityName,
        );
        // 데이터 없음
        // value = PostingPageState.noData(
        //   postId: postId,
        //   communityName: communityName,
        // );
        // 모르는 에러
      }, (data) {
        value = PostingPageState.loadedData(
          postId: postId,
          communityName: communityName,
          postingEntity: data,
        );
      });
    }
  }

  Future<void> setPosting(
      String communityName, int postId, PostingEntity postingEntity) async {
    value = PostingPageState.loadedData(
      postId: postId,
      communityName: communityName,
      postingEntity: postingEntity,
    );
  }

  Future<void> deletePosting(LoginTokenEntity loginToken) async {
    if (value is LoadedDataPostingPageState) {
      value = PostingPageState.loadingDelete(
          postId: postId, communityName: communityName);

      final result = await _postingPageUseCase.deletePosting(
        communityName,
        postId,
        loginToken,
      );

      result.fold((Failure failure) {
        value = PostingPageState.unknownError(
          postId: postId,
          communityName: communityName,
          error: failure,
        );
      }, (data) {
        value = PostingPageState.deletedData(
          postId: postId,
          communityName: communityName,
        );
      });
    }
  }
}
