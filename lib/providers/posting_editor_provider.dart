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
  List<Community> communities = [];
  int selectedCommunityIndex = 0;
  Community? get selectedCommunity =>
      communities.isNotEmpty ? communities[selectedCommunityIndex] : null;

  PostingEdiorState _state = PostingEdiorState.INIT;
  PostingEdiorState get state => _state;
  PostingEditorProvider({required this.api});

  Future<void> fetchCommunities() async {
    try {
      final result = await api.getMainPage();
      if (result != null) {
        communities.addAll(result);
      }
    } catch (error) {
      print(error);
    }
    notifyListeners();
  }

  Future<void> selectCommuinty(String communityName) async {
    selectedCommunityIndex = communities
        .indexWhere((element) => element.communityName == communityName);
    if (selectedCommunityIndex < 0) {
      selectedCommunityIndex = 0;
    }
    notifyListeners();
  }

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
