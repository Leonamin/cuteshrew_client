import 'package:cuteshrew/core/domain/entity/community_entity.dart';

abstract class HomePageState {
  const HomePageState();

  const factory HomePageState.notLoaded() = NotLoadedHomePageState;
  const factory HomePageState.loading() = LoadingHomePageState;
  const factory HomePageState.loadedData({
    required List<CommunityEntity> communities,
    // required Map<String, dynamic> posts,
  }) = LoadedDataHomePageState;
  const factory HomePageState.noData() = NoDataHomePageState;
}

class NotLoadedHomePageState extends HomePageState {
  const NotLoadedHomePageState();
}

class LoadingHomePageState extends HomePageState {
  const LoadingHomePageState();
}

class LoadedDataHomePageState extends HomePageState {
  const LoadedDataHomePageState({
    required this.communities,
    // required this.posts,
  });
  final List<CommunityEntity> communities;
  // final Map<String, dynamic> posts;
}

class NoDataHomePageState extends HomePageState {
  const NoDataHomePageState();
}
