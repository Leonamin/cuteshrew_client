import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/data/posting_detail_data.dart';
import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/posting_editor/large_posting_editor_layout.dart';
import 'package:cuteshrew/presentation/screens/posting_editor/small_posting_editor_layout.dart';
import 'package:cuteshrew/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class PostEditorPageArguments {
  PostingData? originPost;
  bool isModify;

  PostEditorPageArguments(this.originPost, this.isModify);
}

class PostingEditorPage extends StatelessWidget {
  final String communityName;
  final PostingDetailData? originPost;
  final bool isModify;

  const PostingEditorPage({
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
          largeScreen: LargePostingEditorLayout(
            communityName: communityName,
            originPost: originPost,
            isModify: isModify,
          ),
          smallScreen: SmallPostingEditorLayout(
            communityName: communityName,
            originPost: originPost,
            isModify: isModify,
          ),
        ));
  }
}
