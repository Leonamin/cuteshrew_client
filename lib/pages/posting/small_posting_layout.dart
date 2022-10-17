import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/posting/posting_screen.dart';
import 'package:flutter/material.dart';

class SmallPostingLayout extends StatelessWidget {
  Community communityInfo;
  int postId;
  SmallPostingLayout(
      {Key? key, required this.communityInfo, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: PostingScreen(
          communityInfo: communityInfo,
          postId: postId,
        ));
  }
}
