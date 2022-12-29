import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/usecase/create_comment_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/presentation/data/comment_create_data.dart';
import 'package:cuteshrew/presentation/mappers/comment_create_data_mapper.dart';
import 'package:flutter/cupertino.dart';

enum CommentEdiorState {
  INIT,
  LOADING,
  COMPLETED,
  ERROR,
}

class CommentEditorProvider extends ChangeNotifier {
  CommentEdiorState _state = CommentEdiorState.INIT;
  CommentEdiorState get state => _state;
  CommentEditorProvider({
    required CreateCommentUseCase useCase,
  }) {
    _createCommentUseCase = useCase;
  }

  late CreateCommentUseCase _createCommentUseCase;

  Future<CommentEdiorState> uploadComment(
      String communityName,
      LoginTokenEntity loginToken,
      int postId,
      CommentCreateData newComment) async {
    if (_state != CommentEdiorState.LOADING) {
      CommentCreateDataMapper mapper = CommentCreateDataMapper();

      final result = await _createCommentUseCase.createComment(
          postId, mapper.map(newComment), loginToken);
      result.fold((Failure failure) {
        _state = CommentEdiorState.ERROR;
      }, (data) {
        _state = CommentEdiorState.COMPLETED;
      });
    }

    notifyListeners();
    return state;
  }

  Future<CommentEdiorState> uploadReply(
      String communityName,
      LoginTokenEntity loginToken,
      int postId,
      int groupId,
      int commentClass,
      CommentCreateData newComment) async {
    if (_state != CommentEdiorState.LOADING) {
      CommentCreateDataMapper mapper = CommentCreateDataMapper();

      final result = await _createCommentUseCase.createReply(
          postId, groupId, commentClass, mapper.map(newComment), loginToken);
      result.fold((Failure failure) {
        _state = CommentEdiorState.ERROR;
      }, (data) {
        _state = CommentEdiorState.COMPLETED;
      });
    }

    notifyListeners();
    return state;
  }

  Future<CommentEdiorState> updateComment(
      // String communityName,
      LoginTokenEntity token,
      CommentCreateData comment,
      int postId,
      int commentId) async {
    if (_state != CommentEdiorState.LOADING) {
      // TODO implement

      // CommentCreateDataMapper mapper = CommentCreateDataMapper();

      // final result = await _useCase.updateComment(
      //     postId, commentId, mapper.map(newComment), loginToken);
      // result.fold((Failure failure) {
      //   _state = CommentEdiorState.ERROR;
      // }, (data) {
      //   _state = CommentEdiorState.COMPLETED;
      // });
      CommentEdiorState.ERROR;
    }

    notifyListeners();
    return state;
  }
}
