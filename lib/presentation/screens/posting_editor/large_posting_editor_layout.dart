import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/presentation/data/posting_detail_data.dart';
import 'package:cuteshrew/presentation/screens/posting_editor/posting_editor_screen.dart';
import 'package:flutter/material.dart';

class LargePostingEditorLayout extends StatelessWidget {
  final String communityName;
  final PostingDetailData? originPost;
  final bool isModify;

  const LargePostingEditorLayout({
    Key? key,
    required this.communityName,
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
                child: PostingEditorScreen(
                  communityName: communityName,
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
