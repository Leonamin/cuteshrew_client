import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/old/pages/post_editor/post_editor_screen.dart';
import 'package:flutter/material.dart';

class SmallPostEditorLayout extends StatelessWidget {
  Community communityInfo;
  PostDetail? originPost;
  bool isModify;

  SmallPostEditorLayout(
      {Key? key,
      required this.communityInfo,
      this.originPost,
      required this.isModify})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PostEditorScreen(
          communityInfo: communityInfo,
          originPost: originPost,
          isModify: isModify,
        ));
  }
}
