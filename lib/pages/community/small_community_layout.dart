import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/community/community_screen.dart';
import 'package:flutter/material.dart';

class SmallCommunityLayout extends StatelessWidget {
  Community communityInfo;
  int? currentPageNum;
  SmallCommunityLayout(
      {Key? key, required this.communityInfo, this.currentPageNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: CommunityScreen(
          communityInfo: communityInfo,
          currentPageNum: currentPageNum,
        ));
  }
}
