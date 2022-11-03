import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:flutter/cupertino.dart';

enum PostingEdiorState {
  INIT,
  LOADING,
  COMPLETED,
  ERROR,
}

class PostingEditorProvider extends ChangeNotifier {
  final CuteshrewApiClient api;
  PostingEdiorState _state = PostingEdiorState.INIT;
  PostingEdiorState get state => _state;
  PostingEditorProvider({required this.api});

  Future<PostingEdiorState> uploadPosting(
      String communityName, LoginToken token, PostCreate posting) async {
    if (_state != PostingEdiorState.LOADING) {
      try {
        await api.uploadPosting(communityName, token, posting);
        _state = PostingEdiorState.COMPLETED;
      } catch (e) {
        _state = PostingEdiorState.ERROR;
      }
    }

    notifyListeners();
    return state;
  }

  Future<PostingEdiorState> updatePosting(String communityName,
      LoginToken token, PostCreate posting, int postId) async {
    if (_state != PostingEdiorState.LOADING) {
      try {
        await api.updatePosting(communityName, token, postId, posting);
        _state = PostingEdiorState.COMPLETED;
      } catch (e) {
        _state = PostingEdiorState.ERROR;
      }
    }

    notifyListeners();
    return state;
  }
}
