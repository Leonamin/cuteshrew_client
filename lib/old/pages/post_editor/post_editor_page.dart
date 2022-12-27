import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/old/providers/login_notifier.dart';
import 'package:cuteshrew/old/pages/post_editor/large_post_editor_layout.dart';
import 'package:cuteshrew/old/pages/post_editor/small_post_editor_layout.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/common_widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostEditorPageArguments {
  PostDetail? originPost;
  bool isModify;

  PostEditorPageArguments(this.originPost, this.isModify);
}

class PostEditorPage extends StatelessWidget {
  Community communityInfo;
  PostDetail? originPost;
  bool isModify;

  PostEditorPage({
    Key? key,
    required this.communityInfo,
    this.originPost,
    required this.isModify,
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
            largeScreen: LargePostEditorLayout(
              communityInfo: communityInfo,
              originPost: originPost,
              isModify: isModify,
            ),
            smallScreen: SmallPostEditorLayout(
              communityInfo: communityInfo,
              originPost: originPost,
              isModify: isModify,
            ),
          )),
    );
  }
}
