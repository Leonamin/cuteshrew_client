import 'package:cuteshrew/presentation/screens/posting/posting_screen.dart';
import 'package:flutter/material.dart';

class SmallPostingLayout extends StatelessWidget {
  final String communityName;
  final int postId;
  const SmallPostingLayout(
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
