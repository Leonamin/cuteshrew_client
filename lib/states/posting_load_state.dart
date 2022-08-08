import 'package:cuteshrew/models/post_detail.dart';

abstract class PostingLoadState {
  const PostingLoadState({required this.postId, required this.communityName});
  final int postId;
  final String communityName;

  /*
    NotLoaded
    Loading
    Loaded
    NoData
    NeedPassword
    UnknownError
  */

  const factory PostingLoadState.notLoaded({
    required int postId,
    required String communityName,
  }) = NotLoadedPostingLoadState;
  const factory PostingLoadState.loading({
    required int postId,
    required String communityName,
  }) = LoadingPostingLoadState;
  const factory PostingLoadState.loadedData({
    required int postId,
    required String communityName,
    required PostDetail postDetail,
  }) = LoadedDataPostingLoadState;
  const factory PostingLoadState.noData({
    required int postId,
    required String communityName,
  }) = NoDataPostingLoadState;
  const factory PostingLoadState.needPassword({
    required int postId,
    required String communityName,
  }) = NeedPasswordPostingLoadState;
  const factory PostingLoadState.invalidPassword({
    required int postId,
    required String communityName,
    required int failCount,
  }) = InvalidPasswordPostingLoadState;

  const factory PostingLoadState.unknownError({
    required int postId,
    required String communityName,
    required dynamic error,
  }) = UnknownErrorPostingLoadState;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PostingLoadState &&
          postId == other.postId &&
          communityName == other.communityName);

  @override
  int get hashCode => Object.hash(postId, communityName);
}

class NotLoadedPostingLoadState extends PostingLoadState {
  const NotLoadedPostingLoadState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class LoadingPostingLoadState extends PostingLoadState {
  const LoadingPostingLoadState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class LoadedDataPostingLoadState extends PostingLoadState {
  const LoadedDataPostingLoadState(
      {required int postId,
      required String communityName,
      required this.postDetail})
      : super(postId: postId, communityName: communityName);

  final PostDetail postDetail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoadedDataPostingLoadState &&
          postId == other.postId &&
          communityName == other.communityName &&
          postDetail == other.postDetail);

  @override
  int get hashCode => Object.hash(super.hashCode, postDetail.hashCode);
}

class NoDataPostingLoadState extends PostingLoadState {
  const NoDataPostingLoadState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class NeedPasswordPostingLoadState extends PostingLoadState {
  const NeedPasswordPostingLoadState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class InvalidPasswordPostingLoadState extends PostingLoadState {
  const InvalidPasswordPostingLoadState({
    required int postId,
    required String communityName,
    required this.failCount,
  }) : super(postId: postId, communityName: communityName);

  final int failCount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InvalidPasswordPostingLoadState &&
          postId == other.postId &&
          communityName == other.communityName &&
          failCount == other.failCount);

  @override
  int get hashCode => Object.hash(super.hashCode, failCount.hashCode);
}

class UnknownErrorPostingLoadState extends PostingLoadState {
  const UnknownErrorPostingLoadState({
    required int postId,
    required String communityName,
    required this.error,
  }) : super(postId: postId, communityName: communityName);

  final dynamic error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnknownErrorPostingLoadState &&
          postId == other.postId &&
          communityName == other.communityName &&
          error == other.error);

  @override
  int get hashCode => Object.hash(super.hashCode, error.hashCode);
}
