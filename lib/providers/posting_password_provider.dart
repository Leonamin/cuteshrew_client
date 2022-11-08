import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:flutter/cupertino.dart';

enum PostingPasswordState {
  INVALID,
  LOADING,
  VALID,
  ERROR,
}

class PostingPasswordProvider extends ChangeNotifier {
  final CuteshrewApiClient api;
  final Community communityInfo;
  final int postId;
  PostDetail? posting;
  PostingPasswordState _state = PostingPasswordState.INVALID;
  PostingPasswordState get state => _state;

  PostingPasswordProvider(
      {required this.api, required this.communityInfo, required this.postId});

  Future<PostingPasswordState> getPosting(String password) async {
    if (state != PostingPasswordState.LOADING) {
      _state = PostingPasswordState.LOADING;
      notifyListeners();
      try {
        final result =
            await api.getPosting(communityInfo.communityName, postId, password);
        if (result['code'] == 200) {
          _state = PostingPasswordState.VALID;
          posting = result['data'];
        } else if (result['code'] == 403) {
          _state = PostingPasswordState.INVALID;
        }
      } catch (e) {
        print(e);
        _state = PostingPasswordState.ERROR;
      }
    }
    notifyListeners();
    return state;
  }
}
