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
  int commentsCounts = 0;

  bool isLoadingPosting = false;
  bool isLoadingComment = false;

  // hasMore가 false면 5분간 요청하지 않는다.
  bool hasMorePosting = true;
  bool hasMoreComment = true;

  // hasMore가 false일 때 마지막 요청과 비교해서 다시 요청할 조건
  int lastRequestTimePosting = 0;
  int lastRequestTimeComment = 0;

  final requestTerm = const Duration(minutes: 5);

  UserPageProvider({required this.api});

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
}
