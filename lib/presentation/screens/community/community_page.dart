import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/community/large_community_layout.dart';
import 'package:cuteshrew/presentation/screens/community/small_community_layout.dart';
import 'package:cuteshrew/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class CommunityPage extends StatelessWidget {
  final String communityName;
  final int? currentPageNum;

  const CommunityPage({
    Key? key,
    required this.communityName,
    this.currentPageNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        // extendBodyBehindAppBar: true,
        backgroundColor: Theme.of(context).colorScheme.primary,
        appBar: mainAppBar(context, scaffoldKey),
        drawer: const Drawer(),
        body: ResponsiveWidget(
          largeScreen: LargeCommunityLayout(
            communityName: communityName,
            currentPageNum: currentPageNum,
          ),
          smallScreen: SmallCommunityLayout(
            communityName: communityName,
            currentPageNum: currentPageNum,
          ),
        ));
  }
}
