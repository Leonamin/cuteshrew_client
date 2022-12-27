import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/old/providers/login_notifier.dart';
import 'package:cuteshrew/old/pages/community/large_community_layout.dart';
import 'package:cuteshrew/old/pages/community/small_community_layout.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/common_widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPage extends StatelessWidget {
  String communityName;
  int? currentPageNum;

  CommunityPage({
    Key? key,
    required this.communityName,
    this.currentPageNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return ProxyProvider<LoginNotifier, AuthenticationState>(
      update: (context, value, previous) => value.value,
      child: Scaffold(
          key: scaffoldKey,
          // extendBodyBehindAppBar: true,
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
          )),
    );
  }
}
