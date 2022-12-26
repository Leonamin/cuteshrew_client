import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_user_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/comment_detail_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/posting_preview_data_mapper.dart';
import 'package:flutter/material.dart';

enum UserPageState {
  INIT,
  USER_NOT_FOUND,
  USER_FOUND,
}

class UserPageProvider extends ChangeNotifier {
  late ShowUserPageUsecase _userPageUsecase;

  UserPageProvider({required ShowUserPageUsecase userPageUsecase}) {
    _userPageUsecase = userPageUsecase;
  }

  UserPageState _state = UserPageState.INIT;
  UserPageState get state => _state;

  final PostingPreviewDataMapper _postingMapper = PostingPreviewDataMapper();
  final CommentDetailDataMapper _commentMapper = CommentDetailDataMapper();

  final List<PostingEntity> _userPostings = [];
  final List<CommentEntity> _userComments = [];

  // 위젯단에서는 추상화된 데이터를 검사하는걸 최대한 피하자
  // 최대한 위젯단은 받아먹기만 하는거다.
  List<PostingPreviewData> get userPostings => List<PostingPreviewData>.from(
      _userPostings.map((e) => _postingMapper.map(e)));
  List<CommentDetailData> get userComments => List<CommentDetailData>.from(
      _userComments.map((e) => _commentMapper.map(e)));

  int postingCounts = 0;
  int commentCounts = 0;

  bool isLoadingPosting = false;
  bool isLoadingComment = false;

  // hasMore가 false면 5분간 요청하지 않는다.
  bool hasMorePosting = true;
  bool hasMoreComment = true;

  // hasMore가 false일 때 마지막 요청과 비교해서 다시 요청할 조건
  int lastRequestTimePosting = 0;
  int lastRequestTimeComment = 0;

// TODO 이거 posting, comment 분리 해야함
  final requestTerm = const Duration(minutes: 5);

  Future<void> refreshPostings({
    required String userName,
    required int startAtId,
    required int loadCount,
  }) async {
    isLoadingPosting = false;
    hasMorePosting = true;
    lastRequestTimePosting = 0;
    _userPostings.clear();
    return fetchPostings(
        userName: userName, startAtId: startAtId, loadCount: loadCount);
  }

  Future<void> refreshComments({
    required String userName,
    required int startAtId,
    required int loadCount,
  }) async {
    isLoadingComment = false;
    hasMoreComment = true;
    lastRequestTimeComment = 0;
    _userComments.clear();
    fetchComments(
        userName: userName, startAtId: startAtId, loadCount: loadCount);
  }

  Future<void> fetchPostings({
    required String userName,
    required int startAtId,
    required int loadCount,
  }) async {
    // 실행 조건 검사
    // 더이상 포스팅이 없고
    if (!hasMorePosting) {
      // 마지막 요청 시간도 5분 이내면 실행 안함
      if (lastRequestTimePosting < requestTerm.inMilliseconds) {
        return;
      }
    }
    isLoadingPosting = true;
    notifyListeners();

    // 가져오기
    final result =
        await _userPageUsecase.loadPostings(userName, startAtId, loadCount);
    lastRequestTimePosting = DateTime.now().millisecondsSinceEpoch;

    // 검사
    result.fold((Failure failure) {
      _state = UserPageState.USER_NOT_FOUND;
    }, (data) {
      if (_state == UserPageState.INIT) _state = UserPageState.USER_FOUND;

      if (data.isEmpty) {
        hasMorePosting = false;
      } else {
        hasMorePosting = true;
        _userPostings.addAll(data);
      }
    });

    //마지막
    isLoadingPosting = false;
    notifyListeners();
  }

  Future<void> fetchComments({
    required String userName,
    required int startAtId,
    required int loadCount,
  }) async {
    // 실행 조건 검사
    // 더이상 포스팅이 없고
    if (!hasMoreComment) {
      // 마지막 요청 시간도 5분 이내면 실행 안함
      if (lastRequestTimeComment < requestTerm.inMilliseconds) {
        return;
      }
    }
    isLoadingComment = true;
    notifyListeners();

    // 가져오기
    final result =
        await _userPageUsecase.loadComments(userName, startAtId, loadCount);
    lastRequestTimeComment = DateTime.now().millisecondsSinceEpoch;

    // 검사
    result.fold((Failure failure) {
      _state = UserPageState.USER_NOT_FOUND;
    }, (data) {
      if (_state == UserPageState.INIT) _state = UserPageState.USER_FOUND;

      if (data.isEmpty) {
        hasMoreComment = false;
      } else {
        hasMoreComment = true;
        _userComments.addAll(data);
      }
    });

    // 마지막
    isLoadingComment = false;
    notifyListeners();
  }
}
