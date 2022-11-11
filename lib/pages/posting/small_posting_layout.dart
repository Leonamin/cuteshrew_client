import 'package:cuteshrew/pages/posting/posting_screen.dart';
import 'package:flutter/material.dart';

class SmallPostingLayout extends StatelessWidget {
  String communityName;
  int postId;
  SmallPostingLayout(
      {Key? key, required this.communityName, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PostingScreen(
          communityName: communityName,
          postId: postId,
        ));
  }
}
