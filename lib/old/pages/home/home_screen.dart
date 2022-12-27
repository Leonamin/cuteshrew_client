import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/old/providers/home_page_notifier.dart';
import 'package:cuteshrew/old/states/home_page_state.dart';
import 'package:cuteshrew/widgets/community_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final notifier =
            HomePageNotifier(api: context.read<CuteshrewApiClient>());
        notifier.getCommunities();
        return notifier;
      },
      child: ProxyProvider<HomePageNotifier, HomePageState>(
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
  List<Community> communities;
  LoadedDataHomeScreen({Key? key, required this.communities}) : super(key: key);

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
              return CommunityPanel(communityName: communities[index]);
            },
          )
        : ListView.builder(
            shrinkWrap: true,
            itemCount: communities.length,
            itemBuilder: (BuildContext context, int index) {
              return CommunityPanel(communityName: communities[index]);
            },
          );
  }
}
