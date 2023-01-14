import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/posting_preview_data_mapper.dart';
import 'package:cuteshrew/presentation/utils/utils.dart';
import 'package:equatable/equatable.dart';

abstract class CommunityPageState extends Equatable {
  final String communityName;
  final int currentPageNum;
  final int countPerPage;

  const CommunityPageState({
    required this.communityName,
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
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) = NotLoadedCommunityPageState;
  const factory CommunityPageState.loading({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) = LoadingCommunityPageState;
  factory CommunityPageState.loadedData({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required CommunityEntity communityEntity,
    required List<PostingEntity> postingEntityList,
  }) = LoadedDataCommunityPageState;
  const factory CommunityPageState.noData({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) = NoDataCommunityPageState;
  const factory CommunityPageState.unknownError({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required dynamic error,
  }) = UnknownErrorCommunityPageState;

  @override
  List<Object?> get props => [
        communityName,
        currentPageNum,
        countPerPage,
      ];
}

class NotLoadedCommunityPageState extends CommunityPageState {
  const NotLoadedCommunityPageState({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class LoadingCommunityPageState extends CommunityPageState {
  const LoadingCommunityPageState({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class LoadedDataCommunityPageState extends CommunityPageState {
  LoadedDataCommunityPageState({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required CommunityEntity communityEntity,
    required List<PostingEntity> postingEntityList,
  }) : super(
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        ) {
    _communityEntity = communityEntity;
    _postingEntityList = postingEntityList;
  }

  late CommunityEntity _communityEntity;
  late List<PostingEntity> _postingEntityList;

  final PostingPreviewDataMapper _postingPreviewDataMapper =
      PostingPreviewDataMapper();

  String get communityShowName => _communityEntity.communityShowName;
  // FIXME 서버에서 전체 게시글을 주는게 아니라 보낸 게시물 수를 전달 중이라서 지금은 제대로 동작 안함
  // 커뮤니티 전체 게시글 수
  int get communityPostingCount => _communityEntity.postingCount;
  // 현재 페이지의 게시물 개수
  int get currentPagePostingCount => _postingEntityList.length;

  // DONE 이방법은 매우 편하지만 나중에 위젯까지 연결되서 매우 귀찮아지고 힘들어질것이다.
  // 엔티티(도메인) -> 유즈케이스 -> 상태 관리 -> 위젯 이렇게 될텐데
  // 엔티티(도메인) -> 유즈케이스 -> 상태 관리 -> 위젯 모델 <- 위젯 이렇게 바꾸면 위젯은 충격이 덜하겠지
  // 그래서 PostingEntity를 주는게 아니라 PostingWidgetModel 등을 주고 여기서 바꾸는게 낫다.
  // DONE 그래서 Entity -> Data Model로 바꿧다..
  List<PostingPreviewData> get currentPagePostings =>
      List<PostingPreviewData>.from(
          _postingEntityList.map((e) => _postingPreviewDataMapper.map(e)));

  // 안쓸거 같은걸 만들지 말랬지만 만든다.
  // 위의 currentPagePostingCount랑 결합해서 사용하면 될듯
  String postingTitle(int index) => _postingEntityList[index].title;
  int postingId(int index) => _postingEntityList[index].postId;
  int postingCommentCount(int index) => _postingEntityList[index].commentCount;
  bool postingIsLocked(int index) => _postingEntityList[index].isLocked;
  String postingPublishedDateTime(int index) =>
      Utils.formatTimeStamp(_postingEntityList[index].publishedAt);
  String postingUpdatedDateTime(int index) =>
      Utils.formatTimeStamp(_postingEntityList[index].updatedAt);

  @override
  List<Object?> get props =>
      super.props +
      [
        _communityEntity,
      ];
}

class NoDataCommunityPageState extends CommunityPageState {
  const NoDataCommunityPageState({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );
}

class UnknownErrorCommunityPageState extends CommunityPageState {
  const UnknownErrorCommunityPageState({
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required this.error,
  }) : super(
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        );

  final dynamic error;
}
