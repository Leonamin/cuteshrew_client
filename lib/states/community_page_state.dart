import 'package:cuteshrew/model/models.dart';

abstract class CommunityPageState {
  final Community communityInfo;
  final int currentPageNum;
  final int countPerPage;

  const CommunityPageState({
    required this.communityInfo,
    required this.currentPageNum,
    required this.countPerPage,
  });
  /*
  NotLoaded
  Loading
  Loaded
  NoData
  UnknownError
  */

  const factory CommunityPageState.notLoaded({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = NotLoadedCommunityPageState;
  const factory CommunityPageState.loading({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = LoadingCommunityPageState;
  const factory CommunityPageState.loadedData({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = LoadedDataCommunityPageState;
  const factory CommunityPageState.noData({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) = NoDataCommunityPageState;
  const factory CommunityPageState.unknownError({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required dynamic error,
  }) = UnknownErrorCommunityPageState;
}

class NotLoadedCommunityPageState extends CommunityPageState {
  const NotLoadedCommunityPageState({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class LoadingCommunityPageState extends CommunityPageState {
  const LoadingCommunityPageState({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class LoadedDataCommunityPageState extends CommunityPageState {
  const LoadedDataCommunityPageState({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class NoDataCommunityPageState extends CommunityPageState {
  const NoDataCommunityPageState({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class UnknownErrorCommunityPageState extends CommunityPageState {
  const UnknownErrorCommunityPageState({
    required Community communityInfo,
    required int currentPageNum,
    required int countPerPage,
    required this.error,
  }) : super(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );

  final dynamic error;
}
