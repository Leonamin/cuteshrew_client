import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/models/comment_create.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:flutter/cupertino.dart';

enum CommentEdiorState {
  INIT,
  LOADING,
  COMPLETED,
  ERROR,
}

class CommentEditorProvider extends ChangeNotifier {
  final CuteshrewApiClient api;
  CommentEdiorState _state = CommentEdiorState.INIT;
  CommentEdiorState get state => _state;
  CommentEditorProvider({required this.api});

  Future<CommentEdiorState> uploadComment(String communityName,
      LoginToken token, int postId, CommentCreate comment) async {
    if (_state != CommentEdiorState.LOADING) {
      try {
        await api.uploadComment(token, communityName, postId, comment);
        _state = CommentEdiorState.COMPLETED;
      } catch (e) {
        _state = CommentEdiorState.ERROR;
      }
    }

    notifyListeners();
    return state;
  }

  Future<CommentEdiorState> uploadReply(String communityName, LoginToken token,
      int postId, int groupId, CommentCreate comment) async {
    if (_state != CommentEdiorState.LOADING) {
      try {
        await api.uploadReply(token, communityName, postId, groupId, comment);
        _state = CommentEdiorState.COMPLETED;
      } catch (e) {
        _state = CommentEdiorState.ERROR;
      }
    }

    notifyListeners();
    return state;
  }

  Future<CommentEdiorState> updateComment(
      String communityName,
      LoginToken token,
      CommentCreate comment,
      int postId,
      int commentId) async {
    if (_state != CommentEdiorState.LOADING) {
      try {
        await api.updateComment(
            token, communityName, postId, commentId, comment);
        _state = CommentEdiorState.COMPLETED;
      } catch (e) {
        _state = CommentEdiorState.ERROR;
      }
    }

    notifyListeners();
    return state;
  }

  //TODO 현재 생성, 삭제 등 구분이 전혀 안되고 있다. 구분 혹은 분리가 필요하지 않을까
  //완전히 CommentEditor의 Provider도 아니다.
  Future<CommentEdiorState> deleteComment(
      String communityName, LoginToken token, int postId, int commentId) async {
    if (_state != CommentEdiorState.LOADING) {
      try {
        await api.deleteComment(token, communityName, postId, commentId);
        _state = CommentEdiorState.COMPLETED;
      } catch (e) {
        _state = CommentEdiorState.ERROR;
      }
    }

    notifyListeners();
    return state;
  }
}
