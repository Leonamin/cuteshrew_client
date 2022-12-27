import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/old/providers/login_notifier.dart';
import 'package:cuteshrew/old/pages/posting/large_posting_layout.dart';
import 'package:cuteshrew/old/pages/posting/small_posting_layout.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/common_widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostingPage extends StatelessWidget {
  String communityName;
  int postId;
  PostingPage({Key? key, required this.communityName, required this.postId})
      : super(key: key);

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
            largeScreen: LargePostingLayout(
              communityName: communityName,
              postId: postId,
            ),
            smallScreen: SmallPostingLayout(
              communityName: communityName,
              postId: postId,
            ),
          )),
    );
  }
}
