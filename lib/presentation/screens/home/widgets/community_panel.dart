import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/core/domain/entity/community_entity.dart';
import 'package:cuteshrew/core/domain/entity/posting_entity.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/clickable_text.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/posting_item.dart';
import 'package:flutter/material.dart';

class CommunityPanel extends StatelessWidget {
  final CommunityEntity communityInfo;
  final List<PostingEntity> latestPosts;
  final Function()? onPressed;
  const CommunityPanel(
      {Key? key,
      required this.communityInfo,
      required this.latestPosts,
      this.onPressed})
      : super(key: key);

  static const double _paddingItem = 8.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: _paddingItem),
      shrinkWrap: true,
      children: [
        ClickableText(
          text: communityInfo.communityShowName,
          size: 30,
          weight: FontWeight.w800,
          onClick: () {
            locator<NavigationService>().navigateTo(
              Routes.CommuintyNamePageRoute(communityInfo.communityName),
            );
          },
          // onClick: onPressed,
        ),

        const Divider(
          thickness: 3,
          color: Colors.grey,
        ),
        _buildPanelItemColumn(context, latestPosts),
        // _buildPanelItem(communityInfo)
      ],
    );
  }

  Widget _buildPanelItemColumn(
      BuildContext context, List<PostingEntity> posts) {
    return Column(
      children: posts
          .take(5)
          .map((item) => Container(
              height: 40,
              child: PostingItem(
                title: item.title,
                commentCount: item.commentCount,
                onClick: () {
                  locator<NavigationService>().navigateTo(
                      Routes.PostingPageRoute(
                          communityInfo.communityName, item.postId));
                },
              )))
          .toList(),
    );
  }
}
