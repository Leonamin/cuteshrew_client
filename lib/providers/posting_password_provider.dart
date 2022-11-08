import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:flutter/cupertino.dart';

abstract class PostingPasswordState {
  final Community communityInfo;
  final int postId;

  const PostingPasswordState(
      {required this.communityInfo, required this.postId});

  const factory PostingPasswordState.invalid({
    required Community communityInfo,
    required int postId,
  }) = InvalidPassword;

  const factory PostingPasswordState.valid(
      {required Community communityInfo,
      required int postId,
      required PostDetail postDetail}) = ValidPassword;

  const factory PostingPasswordState.loading({
    required Community communityInfo,
    required int postId,
  }) = LoadingPassword;

  const factory PostingPasswordState.error({
    required Community communityInfo,
    required int postId,
    required dynamic error,
  }) = ErrorPassword;
}

class InvalidPassword extends PostingPasswordState {
  const InvalidPassword({required Community communityInfo, required int postId})
      : super(communityInfo: communityInfo, postId: postId);
}

class LoadingPassword extends PostingPasswordState {
  const LoadingPassword({required Community communityInfo, required int postId})
      : super(communityInfo: communityInfo, postId: postId);
}

class ValidPassword extends PostingPasswordState {
  final PostDetail postDetail;
  const ValidPassword(
      {required Community communityInfo,
      required int postId,
      required this.postDetail})
      : super(communityInfo: communityInfo, postId: postId);
}

class ErrorPassword extends PostingPasswordState {
  final dynamic error;

  const ErrorPassword(
      {required Community communityInfo,
      required int postId,
      required this.error})
      : super(communityInfo: communityInfo, postId: postId);
}

class PostingPasswordProvider extends ValueNotifier<PostingPasswordState> {
  final CuteshrewApiClient api;
  Community get communityInfo => value.communityInfo;
  int get postId => value.postId;
  PostingPasswordProvider(
      {required this.api,
      required Community communityInfo,
      required int postId})
      : super(PostingPasswordState.invalid(
            communityInfo: communityInfo, postId: postId));

  Future<void> getPosting(String password) async {
    value = PostingPasswordState.loading(
        communityInfo: communityInfo, postId: postId);

    if (value != LoadingPassword) {
      try {
        final result =
            await api.getPosting(communityInfo.communityName, postId, password);
        if (result['code'] == 200) {
          value = PostingPasswordState.valid(
              communityInfo: communityInfo,
              postId: postId,
              postDetail: result['data']);
        } else if (result['code'] == 403) {
          value = PostingPasswordState.invalid(
              communityInfo: communityInfo, postId: postId);
        }
      } catch (e) {
        print(e);
        value = PostingPasswordState.error(
            communityInfo: communityInfo, postId: postId, error: e);
      }
    }
  }
}
