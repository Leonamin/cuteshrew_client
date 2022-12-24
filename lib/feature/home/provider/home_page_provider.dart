import 'package:cuteshrew/core/domain/usecase/show_main_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/feature/home/provider/home_page_state.dart';
import 'package:flutter/widgets.dart';

class HomePageProvider extends ValueNotifier<HomePageState> {
  HomePageProvider({required ShowMainPageUseCase useCase})
      : super(HomePageState.notLoaded()) {
    _useCase = useCase;
  }

  late ShowMainPageUseCase _useCase;
  final int defaultCommunityLoadCount = 5;

  Future<void> getCommunities() async {
    if (value is! LoadingHomePageState) {
      final result = await _useCase.call(5);

      result.fold((Failure failure) {
        value = const HomePageState.notLoaded();
      }, (data) {
        value = HomePageState.loadedData(communities: data);
      });
    }
  }
}
