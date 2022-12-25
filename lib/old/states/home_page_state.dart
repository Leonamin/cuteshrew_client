import 'package:cuteshrew/model/models.dart';

abstract class HomePageState {
  const HomePageState();

  const factory HomePageState.notLoaded() = NotLoadedHomePageState;
  const factory HomePageState.loading() = LoadingHomePageState;
  const factory HomePageState.loadeddata(
      {required List<Community> communities}) = LoadedDataHomePageState;
  const factory HomePageState.noData() = NoDataHomePageState;
}

class NotLoadedHomePageState extends HomePageState {
  const NotLoadedHomePageState();
}

class LoadingHomePageState extends HomePageState {
  const LoadingHomePageState();
}

class LoadedDataHomePageState extends HomePageState {
  const LoadedDataHomePageState({required this.communities});
  final List<Community> communities;
}

class NoDataHomePageState extends HomePageState {
  const NoDataHomePageState();
}
