import 'package:cuteshrew/core/data/datasource/remote/community_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/community_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/community_preview_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_main_page_usecase.dart';
import 'package:cuteshrew/presentation/screens/home/provider/home_page_provider.dart';
import 'package:cuteshrew/presentation/screens/home/provider/home_page_state.dart';

import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/home/widgets/community_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final notifier = HomePageProvider(
            useCase: ShowMainPageUseCase(
                communityRepository: CommunityRepositoryImpl(
                    communityRemoteDataSource: CommunityRemoteDataSource()),
                postingRepository: PostingRepositoryImpl(
                    postingRemoteDataSource: PostingRemoteDataSource())));
        notifier.getCommunities();
        return notifier;
      },
      child: ProxyProvider<HomePageProvider, HomePageState>(
        update: (context, value, previous) => value.value,
        child: Consumer<HomePageState>(
          builder: (context, value, child) {
            return Scaffold(
              body: () {
                if (value is LoadedDataHomePageState) {
                  return LoadedDataHomeScreen(
                    communities: value.communities,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }(),
            );
          },
        ),
      ),
    );
  }
}

class LoadedDataHomeScreen extends StatelessWidget {
  final List<CommunityEntity> communities;
  const LoadedDataHomeScreen({Key? key, required this.communities})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveWidget.isLargeScreen(context)
        ? MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
            shrinkWrap: true,
            itemCount: communities.length,
            itemBuilder: (BuildContext context, int index) {
              return CommunityPanel(
                communityInfo: communities[index],
                latestPosts: (communities[index] is CommunityPreviewEntity)
                    ? (communities[index] as CommunityPreviewEntity).postings
                    : [],
                onTitlePressed: () {
                  context
                      .read<HomePageProvider>()
                      .navigateToCommunity(communities[index].communityName);
                },
                onItemPressed: (communityName, postId) {
                  context.read<HomePageProvider>().navigateToPosting(
                      communities[index].communityName, postId);
                },
              );
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: communities.length,
            itemBuilder: (BuildContext context, int index) {
              return CommunityPanel(
                communityInfo: communities[index],
                latestPosts: (communities[index] is CommunityPreviewEntity)
                    ? (communities[index] as CommunityPreviewEntity).postings
                    : [],
              );
            },
          );
  }
}
