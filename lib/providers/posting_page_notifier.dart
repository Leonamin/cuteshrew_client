import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/states/posting_page_state.dart';
import 'package:flutter/widgets.dart';

class PostingNotifier extends ValueNotifier<PostingPageState> {
  PostingNotifier({
    required int postId,
    required Community communityInfo,
    required this.api,
  }) : super(PostingPageState.notLoaded(
            postId: postId, communityInfo: communityInfo));

  final CuteshrewApiClient api;

  int get postId => value.postId;
  Community get communityInfo => value.communityInfo;

  Future<void> getPosting([String? password]) async {
    if (value is! LoadingPostingPageState) {
      value = PostingPageState.loading(
          postId: postId, communityInfo: communityInfo);
      try {
        final result =
            await api.getPosting(communityInfo.communityName, postId, password);
        // https://auth0.com/blog/forbidden-unauthorized-http-status-codes/
        if (result['code'] == 200) {
          print("changed");
          value = PostingPageState.loadedData(
              postId: postId,
              communityInfo: communityInfo,
              postDetail: result['data']);
        } else if (result['code'] == 401) {
          value = PostingPageState.needPassword(
            postId: postId,
            communityInfo: communityInfo,
          );
        } else if (result['code'] == 403) {
          //TODO need to change conditional
          value = PostingPageState.invalidPassword(
            postId: postId,
            communityInfo: communityInfo,
            // failCount: result['data']
            failCount: 1,
          );
        } else {
          value = PostingPageState.noData(
            postId: postId,
            communityInfo: communityInfo,
          );
        }
      } catch (error) {
        value = PostingPageState.unknownError(
          postId: postId,
          communityInfo: communityInfo,
          error: error,
        );
      }
    }
  }

  Future<void> deletePosting(LoginToken loginToken) async {
    if (value is LoadedDataPostingPageState) {
      value = PostingPageState.loadingDelete(
          postId: postId, communityInfo: communityInfo);
      try {
        final result = await api.deletePosting(
            communityInfo.communityName, loginToken, postId);
        if (result) {
          value = PostingPageState.deletedData(
              postId: postId, communityInfo: communityInfo);
        } else {
          value = PostingPageState.unknownError(
              postId: postId, communityInfo: communityInfo, error: null);
        }
      } catch (error) {}
    }
  }
}
