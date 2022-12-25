import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/old/states/home_page_state.dart';
import 'package:flutter/widgets.dart';

class HomePageNotifier extends ValueNotifier<HomePageState> {
  HomePageNotifier({required this.api}) : super(HomePageState.notLoaded());

  final CuteshrewApiClient api;

  Future<void> getCommunities() async {
    if (value is! LoadingHomePageState) {
      value = HomePageState.loading();
      try {
        final result = await api.getMainPage();
        if (result != null) {
          value = HomePageState.loadeddata(communities: result);
        } else {
          value = HomePageState.noData();
        }
      } catch (error) {
        value = HomePageState.notLoaded();
        print(error);
      }
    }
  }
}
