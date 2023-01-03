import 'package:cuteshrew/core/domain/usecase/show_main_page_usecase.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/presentation/screens/home/provider/home_page_state.dart';
import 'package:flutter/widgets.dart';

class HomePageProvider extends ValueNotifier<HomePageState> {
  final NavigationService _navigationService = locator<NavigationService>();

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

  void navigateToCommunity(String communityName) {
    _navigationService.navigateTo(Routes.CommuintyNamePageRoute(communityName));
  }

  void navigateToPosting(String communityName, int postId) {
    _navigationService
        .navigateTo(Routes.PostingPageRoute(communityName, postId));
  }
}
