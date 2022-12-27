import 'package:cuteshrew/presentation/screens/community/community_screen.dart';
import 'package:flutter/material.dart';

class SmallCommunityLayout extends StatelessWidget {
  final String communityName;
  final int? currentPageNum;
  const SmallCommunityLayout(
      {Key? key, required this.communityName, this.currentPageNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CommunityScreen(
          communityName: communityName,
          currentPageNum: currentPageNum,
        ));
  }
}
