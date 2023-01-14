import 'package:cuteshrew/core/data/datasource/remote/community_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/community_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/show_main_page_usecase.dart';
import 'package:cuteshrew/presentation/data/community_preview_data.dart';
import 'package:cuteshrew/presentation/screens/home/provider/home_page_provider.dart';
import 'package:cuteshrew/presentation/screens/home/provider/home_page_state.dart';

import 'package:cuteshrew/presentation/screens/home/widgets/community_panel.dart';
import 'package:flutter/material.dart';
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
        update: (context, state, previous) => state.value,
        child: Consumer<HomePageState>(
          builder: (context, state, child) {
            if (state is LoadedDataHomePageState) {
              return LoadedDataHomeScreen(
                communities: state.communityies,
                state: state,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}

class LoadedDataHomeScreen extends StatelessWidget {
  final List<CommunityPreviewData> communities;
  final LoadedDataHomePageState state;
  const LoadedDataHomeScreen(
      {Key? key, required this.communities, required this.state})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: List<Widget>.from(
          communities.map(
            (community) =>
                CommunityPanel(communityName: community.communityName),
          ),
        ),
      ),
    );
  }
}
