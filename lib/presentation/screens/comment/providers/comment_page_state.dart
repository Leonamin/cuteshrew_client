import 'package:cuteshrew/core/domain/entity/comment_detail_entity.dart';
import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/mappers/comment_detail_data_mapper.dart';
import 'package:cuteshrew/presentation/utils/utils.dart';

abstract class CommentPageState {
  final int postId;
  final String communityName;
  final int currentPageNum;
  final int countPerPage;

  const CommentPageState({
    required this.postId,
    required this.communityName,
    required this.currentPageNum,
    required this.countPerPage,
  });

  const factory CommentPageState.notLoaded({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) = NotLoadedCommentPageState;
  const factory CommentPageState.loading({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) = LoadingCommentPageState;
  factory CommentPageState.loadedData({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required List<CommentEntity> commentEntityList,
  }) = LoadedCommentPageState;
  const factory CommentPageState.noData({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) = NoDataCommentPageState;
  const factory CommentPageState.unknownError({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required dynamic error,
  }) = UnknownErrorCommentPageState;
}

class NotLoadedCommentPageState extends CommentPageState {
  const NotLoadedCommentPageState({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
            postId: postId,
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
}

class LoadingCommentPageState extends CommentPageState {
  const LoadingCommentPageState({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
            postId: postId,
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
}

class LoadedCommentPageState extends CommentPageState {
  LoadedCommentPageState({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required List<CommentEntity> commentEntityList,
  }) : super(
          postId: postId,
          communityName: communityName,
          currentPageNum: currentPageNum,
          countPerPage: countPerPage,
        ) {
    _commentEntityList = commentEntityList;
  }

  late List<CommentEntity> _commentEntityList;

  final CommentDetailDataMapper mapper = CommentDetailDataMapper();

  List<CommentDetailData> get commentDataList => List<CommentDetailData>.from(
      _commentEntityList.map((e) => mapper.map(e)));

  CommentEntity _commentEntity(int index) => _commentEntityList[index];

  int commentId(int index) => (_commentEntity(index).commentId);
  int commentPostId(int index) => (_commentEntity(index).postId);
  int commentClass(int index) => (_commentEntity(index).commentClass);
  int commentGroupId(int index) => (_commentEntity(index).groupId);
  int commentOrder(int index) => (_commentEntity(index).order);

  String commentContent(int index) =>
      (_commentEntity(index) is CommentDetailEntity)
          ? (_commentEntity(index) as CommentDetailEntity).comment
          : "";
  String commentWriterName(int index) =>
      (_commentEntity(index) is CommentDetailEntity)
          ? (_commentEntity(index) as CommentDetailEntity).writer.name
          : "unknwon";
  String commentCreatedDateTime(int index) =>
      Utils.formatTimeStamp(_commentEntity(index).createdAt);
}

class NoDataCommentPageState extends CommentPageState {
  const NoDataCommentPageState({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
  }) : super(
            postId: postId,
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);
}

class UnknownErrorCommentPageState extends CommentPageState {
  const UnknownErrorCommentPageState({
    required int postId,
    required String communityName,
    required int currentPageNum,
    required int countPerPage,
    required this.error,
  }) : super(
            postId: postId,
            communityName: communityName,
            currentPageNum: currentPageNum,
            countPerPage: countPerPage);

  final dynamic error;
}
