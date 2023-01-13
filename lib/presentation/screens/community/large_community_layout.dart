import 'package:cuteshrew/presentation/screens/community/community_screen.dart';
import 'package:flutter/material.dart';

class LargeCommunityLayout extends StatelessWidget {
  final String communityName;
  final int? currentPageNum;

  const LargeCommunityLayout(
      {Key? key, required this.communityName, this.currentPageNum})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.transparent,
          ),
        ),
        Expanded(
          flex: 4,
          child: CommunityScreen(
            communityName: communityName,
            currentPageNum: currentPageNum,
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }
}
