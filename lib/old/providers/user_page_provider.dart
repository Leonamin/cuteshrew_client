import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:flutter/material.dart';

enum UserPageState {
  INIT,
  USER_NOT_FOUND,
  USER_FOUND,
}

class UserPageProvider extends ChangeNotifier {
  final CuteshrewApiClient api;

  UserPageState _state = UserPageState.INIT;
  UserPageState get state => _state;

  List<PostPreview> userPostings = [];
  List<CommentPreview> userComments = [];

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

  UserPageProvider({required this.api});

  Future<void> refreshPostings(
      {int? userId, String? userName, int? nextPostId, int? loadPost}) async {
    isLoadingPosting = false;
    hasMorePosting = true;
    lastRequestTimePosting = 0;
    userPostings.clear();
    return fetchPostings(
        userId: userId,
        userName: userName,
        nextPostId: nextPostId,
        loadPost: loadPost);
  }

  Future<void> refreshComments(
      {int? userId, String? userName, int? nextId, int? loadPost}) async {
    isLoadingComment = false;
    hasMoreComment = false;
    lastRequestTimeComment = 0;
    userComments.clear();
    fetchComments(
        userId: userId, userName: userName, nextId: nextId, loadPost: loadPost);
  }

  Future<void> fetchPostings(
      {int? userId, String? userName, int? nextPostId, int? loadPost}) async {
    // 더이상 포스팅이 없고
    if (!hasMorePosting) {
      // 마지막 요청 시간도 5분 이내면
      if (lastRequestTimePosting < requestTerm.inMilliseconds) {
        return;
      }
    }
    isLoadingPosting = true;
    notifyListeners();
    try {
      final result = await api.searchPostings(userId, userName, nextPostId, 5);
      if (result['code'] == 200) {
        _state = UserPageState.USER_FOUND;
        final responsePostings =
            (result['data'] as ResponseSearchPostings).postings;
        postingCounts =
            (result['data'] as ResponseSearchPostings).postingCounts;
        if (responsePostings.isEmpty) {
          hasMorePosting = false;
        } else {
          userPostings.addAll(responsePostings);
          hasMorePosting = true;
        }
      } else {
        _state = UserPageState.USER_NOT_FOUND;
      }
    } catch (e) {
      print(e);
      lastRequestTimePosting = DateTime.now().millisecondsSinceEpoch;
      hasMorePosting = false;
    }
    isLoadingPosting = false;
    notifyListeners();
  }

  Future<void> fetchComments(
      {int? userId, String? userName, int? nextId, int? loadPost}) async {
    // 더이상 포스팅이 없고
    if (!hasMoreComment) {
      // 마지막 요청 시간도 5분 이내면
      if (lastRequestTimeComment < requestTerm.inMilliseconds) {
        return;
      }
    }
    isLoadingComment = true;
    notifyListeners();
    try {
      final result = await api.searchComments(userId, userName, nextId, 5);
      if (result['code'] == 200) {
        if (_state == UserPageState.INIT) _state = UserPageState.USER_FOUND;

        final response = (result['data'] as ResponseSearchComments).comments;
        commentCounts =
            (result['data'] as ResponseSearchComments).commentCounts;
        if (response.isEmpty) {
          hasMoreComment = false;
        } else {
          userComments.addAll(response);
          hasMoreComment = true;
        }
      } else {
        _state = UserPageState.USER_NOT_FOUND;
      }
    } catch (e) {
      print(e);
      lastRequestTimeComment = DateTime.now().millisecondsSinceEpoch;
      hasMoreComment = false;
    }
    isLoadingComment = false;
    notifyListeners();
  }
}
