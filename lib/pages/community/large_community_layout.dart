import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/community/community_screen.dart';
import 'package:flutter/material.dart';

class LargeCommunityLayout extends StatelessWidget {
  Community communityInfo;
  int? currentPageNum;

  LargeCommunityLayout(
      {Key? key, required this.communityInfo, this.currentPageNum})
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
                child: CommunityScreen(
                  communityInfo: communityInfo,
                  currentPageNum: currentPageNum,
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
