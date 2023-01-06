import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/usecase/create_posting_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/data/community_data.dart';
import 'package:cuteshrew/presentation/data/posting_create_data.dart';
import 'package:cuteshrew/presentation/mappers/community_preview_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/posting_create_data_mapper.dart';
import 'package:flutter/cupertino.dart';

enum PostingEdiorState {
  INIT,
  LOADING,
  COMPLETED,
  ERROR,
}

class PostingEditorProvider extends ChangeNotifier {
  final NavigationService _navigationService = locator<NavigationService>();

  PostingEdiorState _state = PostingEdiorState.INIT;
  PostingEdiorState get state => _state;
  PostingEditorProvider({required CreatePostingUseCase useCase}) {
    _useCase = useCase;
  }

  late CreatePostingUseCase _useCase;

  List<CommunityData> communities = [];
  int selectedCommunityIndex = 0;
  CommunityData? get selectedCommunity =>
      communities.isNotEmpty ? communities[selectedCommunityIndex] : null;

  String get selectedCommunityName => communities.isNotEmpty
      ? communities[selectedCommunityIndex].communityName
      : "";

  String get selectedCommunityShowName => communities.isNotEmpty
      ? communities[selectedCommunityIndex].communityShowName
      : "";

  Future<void> fetchCommunities() async {
    final result = await _useCase();
    result.fold((Failure failure) {}, (data) {
      CommunityPreviewDataMapper mapper = CommunityPreviewDataMapper();
      communities.addAll(List.from(data.map(
        (e) => mapper.map(e),
      )));
    });
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
    String communityName,
    LoginTokenEntity loginToken,
    PostingCreateData newPosting,
  ) async {
    if (_state != PostingEdiorState.LOADING) {
      PostingCreateDataMapper mapper = PostingCreateDataMapper();

      final result = await _useCase.createPosting(
          communityName, mapper.map(newPosting), loginToken);
      result.fold((Failure failure) {
        _state = PostingEdiorState.ERROR;
      }, (data) {
        _state = PostingEdiorState.COMPLETED;
      });
    }

    notifyListeners();
    return state;
  }

  Future<PostingEdiorState> updatePosting(
    String communityName,
    LoginTokenEntity loginToken,
    PostingCreateData newPosting,
    int postId,
  ) async {
    if (_state != PostingEdiorState.LOADING) {
      PostingCreateDataMapper mapper = PostingCreateDataMapper();

      final result = await _useCase.updatePosting(
          communityName, postId, mapper.map(newPosting), loginToken);
      result.fold((Failure failure) {
        _state = PostingEdiorState.ERROR;
      }, (data) {
        _state = PostingEdiorState.COMPLETED;
      });
    }

    notifyListeners();
    return state;
  }

  void goBack() {
    _navigationService.goBack();
  }
}
