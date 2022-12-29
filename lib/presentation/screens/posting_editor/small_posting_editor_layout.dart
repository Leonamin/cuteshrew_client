import 'package:cuteshrew/presentation/data/posting_detail_data.dart';
import 'package:cuteshrew/presentation/screens/posting_editor/posting_editor_screen.dart';
import 'package:flutter/material.dart';

class SmallPostingEditorLayout extends StatelessWidget {
  final String communityName;
  final PostingDetailData? originPost;
  final bool isModify;

  const SmallPostingEditorLayout(
      {Key? key,
      required this.communityName,
      this.originPost,
      required this.isModify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PostingEditorScreen(
          communityName: communityName,
          originPost: originPost,
          isModify: isModify,
        ));
  }
}
