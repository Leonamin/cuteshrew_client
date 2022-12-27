import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/data/posting_detail_data.dart';
import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/comment_editor/large_post_editor_layout.dart';
import 'package:cuteshrew/presentation/screens/comment_editor/small_post_editor_layout.dart';
import 'package:cuteshrew/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class PostEditorPageArguments {
  PostingData? originPost;
  bool isModify;

  PostEditorPageArguments(this.originPost, this.isModify);
}

class PostEditorPage extends StatelessWidget {
  final String communityName;
  final PostingDetailData? originPost;
  final bool isModify;

  const PostEditorPage({
    Key? key,
    required this.communityName,
    this.originPost,
    required this.isModify,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        // extendBodyBehindAppBar: true,
        appBar: mainAppBar(context, scaffoldKey),
        drawer: const Drawer(),
        body: ResponsiveWidget(
          largeScreen: LargePostEditorLayout(
            communityName: communityName,
            originPost: originPost,
            isModify: isModify,
          ),
          smallScreen: SmallPostEditorLayout(
            communityName: communityName,
            originPost: originPost,
            isModify: isModify,
          ),
        ));
  }
}
