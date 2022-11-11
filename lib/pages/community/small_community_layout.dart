import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/community/community_screen.dart';
import 'package:flutter/material.dart';

class SmallCommunityLayout extends StatelessWidget {
  String communityName;
  int? currentPageNum;
  SmallCommunityLayout(
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
