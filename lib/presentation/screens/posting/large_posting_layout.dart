import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/presentation/screens/posting/posting_screen.dart';
import 'package:flutter/material.dart';

class LargePostingLayout extends StatelessWidget {
  final String communityName;
  final int postId;

  const LargePostingLayout(
      {Key? key, required this.communityName, required this.postId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: lightGrey,
          ),
        ),
        Expanded(
            flex: 4,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PostingScreen(
                  communityName: communityName,
                  postId: postId,
                ))),
        Expanded(
          flex: 1,
          child: Container(
            color: lightGrey,
          ),
        ),
      ],
    );
  }
}
