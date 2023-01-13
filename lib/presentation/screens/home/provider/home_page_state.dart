import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/community_preview_entity.dart';
import 'package:cuteshrew/presentation/data/community_preview_data.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/mappers/community_preview_data_mapper.dart';
import 'package:cuteshrew/presentation/mappers/posting_preview_data_mapper.dart';

abstract class HomePageState {
  const HomePageState();

  const factory HomePageState.notLoaded() = NotLoadedHomePageState;
  const factory HomePageState.loading() = LoadingHomePageState;
  factory HomePageState.loadedData({
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
  LoadedDataHomePageState({
    required List<CommunityEntity> communities,
    // required this.posts,
  }) {
    _communities = communities;
  }
  late List<CommunityEntity> _communities;

  final CommunityPreviewDataMapper communityPreviewMapper =
      CommunityPreviewDataMapper();
  final PostingPreviewDataMapper postingPreviewMapper =
      PostingPreviewDataMapper();

  List<CommunityPreviewData> get communityies =>
      List<CommunityPreviewData>.from(
          _communities.map((e) => communityPreviewMapper.map(e)));

  List<PostingPreviewData> communityPostings(int index) =>
      (_communities[index] is CommunityPreviewEntity)
          ? List<PostingPreviewData>.from((_communities[index]
                  as CommunityPreviewEntity)
              .postings
              .map((postingEntity) => postingPreviewMapper.map(postingEntity)))
          : [];
}

class NoDataHomePageState extends HomePageState {
  const NoDataHomePageState();
}
