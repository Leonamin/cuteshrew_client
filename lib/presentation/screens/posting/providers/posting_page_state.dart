import 'package:cuteshrew/core/domain/entity/posting_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/presentation/utils/utils.dart';
import 'package:equatable/equatable.dart';

abstract class PostingPageState extends Equatable {
  const PostingPageState({
    required this.postId,
    required this.communityName,
  });
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

  const factory PostingPageState.notLoaded({
    required int postId,
    required String communityName,
  }) = NotLoadedPostingPageState;
  const factory PostingPageState.loading({
    required int postId,
    required String communityName,
  }) = LoadingPostingPageState;
  factory PostingPageState.loadedData({
    required int postId,
    required String communityName,
    required PostingEntity postingEntity,
  }) = LoadedDataPostingPageState;
  const factory PostingPageState.noData({
    required int postId,
    required String communityName,
  }) = NoDataPostingPageState;
  const factory PostingPageState.needPassword({
    required int postId,
    required String communityName,
  }) = NeedPasswordPostingPageState;
  const factory PostingPageState.loadingDelete({
    required int postId,
    required String communityName,
  }) = LoadingDeletePostingPageState;
  const factory PostingPageState.deletedData({
    required int postId,
    required String communityName,
  }) = DeletedDataPostingPageState;
  const factory PostingPageState.unknownError({
    required int postId,
    required String communityName,
    required dynamic error,
  }) = UnknownErrorPostingPageState;

  @override
  List<Object?> get props => [
        postId,
        communityName,
      ];
}

class NotLoadedPostingPageState extends PostingPageState {
  const NotLoadedPostingPageState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class LoadingPostingPageState extends PostingPageState {
  const LoadingPostingPageState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

// 최대한 postDetail을 직접 쓰는게 아닌 인자를 state를 통해서 받을 수 있게한다
// 일종의 뷰모델로써 기능한다.
class LoadedDataPostingPageState extends PostingPageState {
  LoadedDataPostingPageState({
    required int postId,
    required String communityName,
    required PostingEntity postingEntity,
  }) : super(postId: postId, communityName: communityName) {
    _postingEntity = postingEntity;
  }

  late PostingEntity _postingEntity;

  String get communityShowName => (_postingEntity is PostingDetailEntity)
      ? (_postingEntity as PostingDetailEntity).ownCommunity.communityShowName
      : communityName;

  String get publishedDateTime =>
      Utils.formatTimeStamp(_postingEntity.publishedAt);
  String get updatedDateTime => Utils.formatTimeStamp(_postingEntity.updatedAt);
  String get title => _postingEntity.title;
  int get commentCount => _postingEntity.commentCount;
  String get showCommentCount =>
      (commentCount <= 99 ? commentCount.toString() : "99+");
  String get writerName => (_postingEntity is PostingDetailEntity)
      ? ((_postingEntity as PostingDetailEntity)).writer.name
      : "Unknown";

  @override
  List<Object?> get props => [
        postId,
        communityName,
        _postingEntity,
      ];
}

class NoDataPostingPageState extends PostingPageState {
  const NoDataPostingPageState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class NeedPasswordPostingPageState extends PostingPageState {
  const NeedPasswordPostingPageState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class LoadingDeletePostingPageState extends PostingPageState {
  const LoadingDeletePostingPageState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class DeletedDataPostingPageState extends PostingPageState {
  const DeletedDataPostingPageState({
    required int postId,
    required String communityName,
  }) : super(postId: postId, communityName: communityName);
}

class UnknownErrorPostingPageState extends PostingPageState {
  const UnknownErrorPostingPageState({
    required int postId,
    required String communityName,
    required this.error,
  }) : super(postId: postId, communityName: communityName);

  final dynamic error;

  @override
  List<Object?> get props => [
        postId,
        communityName,
        error,
      ];
}
