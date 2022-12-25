import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';

abstract class PostingPageState {
  const PostingPageState({required this.postId, required this.communityInfo});
  final int postId;
  final Community communityInfo;

  /*
    NotLoaded
    Loading
    Loaded
    NoData
    NeedPassword
    UnknownError
  */

  const factory PostingPageState.notLoaded({
    required int postId,
    required Community communityInfo,
  }) = NotLoadedPostingPageState;
  const factory PostingPageState.loading({
    required int postId,
    required Community communityInfo,
  }) = LoadingPostingPageState;
  const factory PostingPageState.loadedData({
    required int postId,
    required Community communityInfo,
    required PostDetail postDetail,
  }) = LoadedDataPostingPageState;
  const factory PostingPageState.noData({
    required int postId,
    required Community communityInfo,
  }) = NoDataPostingPageState;
  const factory PostingPageState.needPassword({
    required int postId,
    required Community communityInfo,
  }) = NeedPasswordPostingPageState;
  // const factory PostingPageState.invalidPassword({
  //   required int postId,
  //   required Community communityInfo,
  //   required int failCount,
  // }) = InvalidPasswordPostingPageState;
  const factory PostingPageState.loadingDelete({
    required int postId,
    required Community communityInfo,
  }) = LoadingDeletePostingPageState;
  const factory PostingPageState.deletedData({
    required int postId,
    required Community communityInfo,
  }) = DeletedDataPostingPageState;
  const factory PostingPageState.unknownError({
    required int postId,
    required Community communityInfo,
    required dynamic error,
  }) = UnknownErrorPostingPageState;

  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     (other is PostingPageState &&
  //         postId == other.postId &&
  //         communityInfo == other.communityInfo);

  // @override
  // int get hashCode => Object.hash(postId, communityInfo);
}

class NotLoadedPostingPageState extends PostingPageState {
  const NotLoadedPostingPageState({
    required int postId,
    required Community communityInfo,
  }) : super(postId: postId, communityInfo: communityInfo);
}

class LoadingPostingPageState extends PostingPageState {
  const LoadingPostingPageState({
    required int postId,
    required Community communityInfo,
  }) : super(postId: postId, communityInfo: communityInfo);
}

class LoadedDataPostingPageState extends PostingPageState {
  const LoadedDataPostingPageState(
      {required int postId,
      required Community communityInfo,
      required this.postDetail})
      : super(postId: postId, communityInfo: communityInfo);

  final PostDetail postDetail;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoadedDataPostingPageState &&
          postId == other.postId &&
          communityInfo == other.communityInfo &&
          postDetail == other.postDetail);

  @override
  int get hashCode => Object.hash(super.hashCode, postDetail.hashCode);
}

class NoDataPostingPageState extends PostingPageState {
  const NoDataPostingPageState({
    required int postId,
    required Community communityInfo,
  }) : super(postId: postId, communityInfo: communityInfo);
}

class NeedPasswordPostingPageState extends PostingPageState {
  const NeedPasswordPostingPageState({
    required int postId,
    required Community communityInfo,
  }) : super(postId: postId, communityInfo: communityInfo);
}

// class InvalidPasswordPostingPageState extends PostingPageState {
//   const InvalidPasswordPostingPageState({
//     required int postId,
//     required Community communityInfo,
//     required this.failCount,
//   }) : super(postId: postId, communityInfo: communityInfo);

//   final int failCount;

//   @override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       (other is InvalidPasswordPostingPageState &&
//           postId == other.postId &&
//           communityInfo == other.communityInfo &&
//           failCount == other.failCount);

//   @override
//   int get hashCode => Object.hash(super.hashCode, failCount.hashCode);
// }

class LoadingDeletePostingPageState extends PostingPageState {
  const LoadingDeletePostingPageState({
    required int postId,
    required Community communityInfo,
  }) : super(postId: postId, communityInfo: communityInfo);

  // final PostDetail postDetail;
  // @override
  // bool operator ==(Object other) =>
  //     identical(this, other) ||
  //     (other is LoadingDeletePostingPageState &&
  //         postId == other.postId &&
  //         communityInfo == other.communityInfo &&
  //         postDetail == other.postDetail);

  // @override
  // int get hashCode => Object.hash(super.hashCode, postDetail.hashCode);
}

class DeletedDataPostingPageState extends PostingPageState {
  const DeletedDataPostingPageState({
    required int postId,
    required Community communityInfo,
  }) : super(postId: postId, communityInfo: communityInfo);
}

class UnknownErrorPostingPageState extends PostingPageState {
  const UnknownErrorPostingPageState({
    required int postId,
    required Community communityInfo,
    required this.error,
  }) : super(postId: postId, communityInfo: communityInfo);

  final dynamic error;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UnknownErrorPostingPageState &&
          postId == other.postId &&
          communityInfo == other.communityInfo &&
          error == other.error);

  @override
  int get hashCode => Object.hash(super.hashCode, error.hashCode);
}
