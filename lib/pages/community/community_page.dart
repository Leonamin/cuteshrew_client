import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/providers/login_notifier.dart';
import 'package:cuteshrew/pages/community/large_community_layout.dart';
import 'package:cuteshrew/pages/community/small_community_layout.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatelessWidget {
  Community communityInfo;
  int? currentPageNum;

  CommunityPage({
    Key? key,
    required this.communityInfo,
    this.currentPageNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return ProxyProvider<LoginNotifier, LoginState>(
      update: (context, value, previous) => value.value,
      child: Scaffold(
          key: scaffoldKey,
          // extendBodyBehindAppBar: true,
          appBar: mainAppBar(context, scaffoldKey),
          drawer: const Drawer(),
          body: ResponsiveWidget(
            largeScreen: LargeCommunityLayout(
              communityInfo: communityInfo,
              currentPageNum: currentPageNum,
            ),
            smallScreen: SmallCommunityLayout(
              communityInfo: communityInfo,
              currentPageNum: currentPageNum,
            ),
          )),
    );
  }
}
