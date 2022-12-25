import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_detail.dart';

abstract class CommentPageState {
  final int postId;
  final Community communityInfo;
  final int currentPageNum;
  final int countPerPage;

  const CommentPageState({
    required this.postId,
    required this.communityInfo,
    required this.currentPageNum,
    required this.countPerPage,
  });

  const factory CommentPageState.notLoaded({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = NotLoadedCommentPageState;
  const factory CommentPageState.loading({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = LoadingCommentPageState;
  const factory CommentPageState.loadedData({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required List<CommentDetail> comments,
  }) = LoadedCommentPageState;
  const factory CommentPageState.noData({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = NoDataCommentPageState;
  const factory CommentPageState.unknownError({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required dynamic error,
  }) = UnknownErrorCommentPageState;
}

class NotLoadedCommentPageState extends CommentPageState {
  const NotLoadedCommentPageState({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
}

class LoadingCommentPageState extends CommentPageState {
  const LoadingCommentPageState({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
}

class LoadedCommentPageState extends CommentPageState {
  const LoadedCommentPageState({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required this.comments,
  }) : super(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);

  final List<CommentDetail> comments;
}

class NoDataCommentPageState extends CommentPageState {
  const NoDataCommentPageState({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
}

class UnknownErrorCommentPageState extends CommentPageState {
  const UnknownErrorCommentPageState({
    required int postId,
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required this.error,
  }) : super(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);

  final dynamic error;
}
