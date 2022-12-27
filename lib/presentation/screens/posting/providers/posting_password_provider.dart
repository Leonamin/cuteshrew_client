import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_posting_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:flutter/cupertino.dart';

enum PostingPasswordState {
  INVALID,
  LOADING,
  VALID,
  ERROR,
}

class PostingPasswordProvider extends ChangeNotifier {
  final String communityName;
  final int postId;
  // 임시로 넘겨주는 역할만 하니까 그냥 쓰기
  PostingEntity? posting;
  PostingPasswordState _state = PostingPasswordState.INVALID;
  PostingPasswordState get state => _state;

  late ShowPostingPageUseCase _useCase;

  PostingPasswordProvider(
      {required ShowPostingPageUseCase useCase,
      required this.communityName,
      required this.postId}) {
    _useCase = useCase;
  }

  Future<PostingPasswordState> getPosting(String password) async {
    if (state != PostingPasswordState.LOADING) {
      _state = PostingPasswordState.LOADING;
      notifyListeners();

      final result = await _useCase(communityName, postId, password);

      result.fold((Failure failure) {
        // TODO 에러인지 비밀번호 틀림인지 체크
        // code 403 invalid
        // others error
        _state = PostingPasswordState.INVALID;
      }, (data) {
        _state = PostingPasswordState.VALID;
      });
    }
    notifyListeners();
    return state;
  }
}
