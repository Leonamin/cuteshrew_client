import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/pages/post_editor/post_editor_screen.dart';
import 'package:flutter/material.dart';

class LargePostEditorLayout extends StatelessWidget {
  Community communityInfo;
  PostDetail? originPost;
  bool isModify;

  LargePostEditorLayout({
    Key? key,
    required this.communityInfo,
    this.originPost,
    required this.isModify,
  }) : super(key: key);

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
                child: PostEditorScreen(
                  communityInfo: communityInfo,
                  originPost: originPost,
                  isModify: isModify,
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
