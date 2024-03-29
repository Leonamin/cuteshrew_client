import 'package:cuteshrew/core/domain/entity/comment_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_detail_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_user_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/comment_detail_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/posting_preview_data_mapper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum UserPageState {
  INIT,
  USER_NOT_FOUND,
  USER_FOUND,
}

class UserPageProvider extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();

  late ShowUserPageUsecase _userPageUsecase;

  UserPageProvider({required ShowUserPageUsecase userPageUsecase}) {
    _userPageUsecase = userPageUsecase;
  }

  UserPageState _state = UserPageState.INIT;
  UserPageState get state => _state;

  final PostingPreviewDataMapper _postingMapper = PostingPreviewDataMapper();
  final CommentDetailDataMapper _commentMapper = CommentDetailDataMapper();

  UserDetailEntity? _userInfo;
  final List<PostingEntity> _userPostings = [];
  final List<CommentEntity> _userComments = [];

  // 위젯단에서는 추상화된 데이터를 검사하는걸 최대한 피하자
  // 최대한 위젯단은 받아먹기만 하는거다.
  List<PostingPreviewData> get userPostings => List<PostingPreviewData>.from(
      _userPostings.map((e) => _postingMapper.map(e)));
  List<CommentDetailData> get userComments => List<CommentDetailData>.from(
      _userComments.map((e) => _commentMapper.map(e)));

  // 유저 정보
  int get getEntirePostingCount => _userInfo?.postingCount ?? 0;
  int get getEntireCommentCount => _userInfo?.commentCount ?? 0;
  String get userName => _userInfo?.name ?? "";
  String get userEmail => _userInfo?.email ?? "";
  String get userIntroduction => _userInfo?.introduction ?? "";

  // 게시글 정보
  String postingTitle(int index) => userPostings[index].title;
  int postingCommentCount(int index) => userPostings[index].commentCount;
  String postingCommunityName(int index) =>
      userPostings[index].ownCommunity?.communityName ?? "";
  int postingId(int index) => userPostings[index].postId;
  String postingDateTime(int index) =>
      DateFormat('yy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(
          userPostings[index].publishedAt * 1000));
  int get lastPostingId => userPostings.last.postId;

  // 댓글 정보
  // 이름 안헷갈리게 AtIndex 붙임
  String commentAtIndex(int index) => userComments[index].comment;
  String commentPostingTitle(int index) =>
      userComments[index].parentPosting.title;
  String commentPostingCommunityName(int index) =>
      userComments[index].parentPosting.ownCommunity?.communityName ?? "";
  int commentPostingId(int index) => userComments[index].postId;
  String commentPostingDateTime(int index) =>
      DateFormat('yy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(
          userComments[index].parentPosting.publishedAt * 1000));
  String commentDateTime(int index) =>
      DateFormat('yy.MM.dd').format(DateTime.fromMillisecondsSinceEpoch(
          userComments[index].createdAt * 1000));
  int get lastCommentId => userComments.last.commentId;
  int get lastCommentPostingId => userComments.last.postId;

  bool isLoadingPosting = false;
  bool isLoadingComment = false;

  // hasMore가 false면 5분간 요청하지 않는다.
  bool hasMorePosting = true;
  bool hasMoreComment = true;

  // hasMore가 false일 때 마지막 요청과 비교해서 다시 요청할 조건
  int lastRequestTimePosting = 0;
  int lastRequestTimeComment = 0;

  final requestTerm = const Duration(minutes: 5);

  final defaultLoadCount = 10;

  Future<void> call({required String userName}) async {
// 가져오기
    final result = await _userPageUsecase(userName);

    // 검사
    result.fold((Failure failure) {
      _state = UserPageState.USER_NOT_FOUND;
    }, (data) {
      _state = UserPageState.USER_FOUND;
      _userInfo = data;
    });

    //마지막
    notifyListeners();
  }

  Future<void> refreshPostings({
    required String userName,
  }) async {
    isLoadingPosting = false;
    hasMorePosting = true;
    lastRequestTimePosting = 0;
    _userPostings.clear();
    return fetchPostings(userName: userName);
  }

  Future<void> refreshComments({
    required String userName,
  }) async {
    isLoadingComment = false;
    hasMoreComment = true;
    lastRequestTimeComment = 0;
    _userComments.clear();
    fetchComments(userName: userName);
  }

  Future<void> fetchPostings({
    required String userName,
    int? startAtId,
    int? loadCount,
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
    final result = await _userPageUsecase.loadPostings(
        userName, startAtId, loadCount ?? defaultLoadCount);
    lastRequestTimePosting = DateTime.now().millisecondsSinceEpoch;

    // 검사
    result.fold((Failure failure) {
      // _state = UserPageState.USER_NOT_FOUND;
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
    int? startAtId,
    int? loadCount,
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
    final result = await _userPageUsecase.loadComments(
        userName, startAtId, loadCount ?? defaultLoadCount);
    lastRequestTimeComment = DateTime.now().millisecondsSinceEpoch;

    // 검사
    result.fold((Failure failure) {
      // _state = UserPageState.USER_NOT_FOUND;
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

  void navigateToHome() {
    _navigationService.navigateTo(Routes.HomePageRoute);
  }

  void navigateToPosting(String communityName, int postId) {
    _navigationService
        .navigateTo(Routes.PostingPageRoute(communityName, postId));
  }
}
