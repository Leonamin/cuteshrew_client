import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/posting/posting_screen.dart';
import 'package:flutter/material.dart';

class LargePostingLayout extends StatelessWidget {
  Community communityInfo;
  int postId;

  LargePostingLayout(
      {Key? key, required this.communityInfo, required this.postId})
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
                  communityInfo: communityInfo,
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
