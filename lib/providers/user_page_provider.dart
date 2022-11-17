import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:flutter/material.dart';

class UserPageProvider extends ChangeNotifier {
  final CuteshrewApiClient api;

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
      final result =
          await api.searchPostings(userId, userName, nextPostId, loadPost);
      if (result['code'] == 200) {
        final responsePostings =
            (result['data'] as ResponseSearchPostings).postings;
        if (responsePostings.isEmpty) {
          hasMorePosting = false;
        } else {
          userPostings.addAll(responsePostings);
          hasMorePosting = true;
        }
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
