import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/widgets/clickable_text.dart';
import 'package:cuteshrew/widgets/posting_item.dart';
import 'package:flutter/material.dart';

class CommunityPanel extends StatelessWidget {
  final Community communityInfo;
  const CommunityPanel({Key? key, required this.communityInfo})
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
            Navigator.pushNamed(context,
                Routes.CommuintyNamePageRoute(communityInfo.communityName));
          },
        ),

        const Divider(
          thickness: 3,
          color: Colors.grey,
        ),
        _buildPanelItemColumn(context, communityInfo),
        // _buildPanelItem(communityInfo)
      ],
    );
  }

  Widget _buildPanelItem(Community community) {
    List<Post> posts = community.latestPostingList;
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: posts.length > 10 ? 10 : posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 30,
              child: PostingItem(
                posting: posts[index],
                onClick: () {
                  Navigator.pushNamed(
                      context,
                      Routes.PostingPageRoute(
                          communityInfo.communityName, posts[index].postId));
                },
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 1,
            indent: _paddingItem,
            endIndent: _paddingItem,
          );
        });
  }

  Widget _buildPanelItemColumn(BuildContext context, Community community) {
    List<Post> posts = community.latestPostingList;

    return Column(
      children: posts
          .take(5)
          .map((item) => Container(
              height: 40,
              child: PostingItem(
                posting: item,
                onClick: () {
                  Navigator.pushNamed(
                      context,
                      Routes.PostingPageRoute(
                          communityInfo.communityName, item.postId));
                },
              )))
          .toList(),
    );
  }
}
