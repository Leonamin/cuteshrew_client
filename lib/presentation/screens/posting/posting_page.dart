import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/posting/large_posting_layout.dart';
import 'package:cuteshrew/presentation/screens/posting/small_posting_layout.dart';
import 'package:cuteshrew/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class PostingPage extends StatelessWidget {
  final String communityName;
  final int postId;
  const PostingPage(
      {Key? key, required this.communityName, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
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
        ));
  }
}
