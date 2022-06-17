import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/community_page.dart';
import 'package:cuteshrew/pages/posting_page.dart';
import 'package:cuteshrew/widgets/community_title/community_title.dart';
import 'package:cuteshrew/widgets/posting_item/posting_item.dart';
import 'package:flutter/material.dart';

class CommunityPanel extends StatelessWidget {
  final Community communityInfo;
  const CommunityPanel({Key? key, required this.communityInfo})
      : super(key: key);

  static const double _paddingItem = 10.0;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(_paddingItem),
          child: CommunityTitle(
              title: communityInfo.communityShowName,
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CommunityPage(community: communityInfo)),
                );
              }),
        ),
        const Divider(
          thickness: 3,
          color: Colors.grey,
          indent: _paddingItem,
          endIndent: _paddingItem,
        ),
        _buildPanelItem(communityInfo)
      ],
    );
  }

  Widget _buildPanelItem(Community community) {
    List<Post> posts = community.latestPostingList;
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: posts.length > 10 ? 10 : posts.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
              height: 30,
              child: PostingItem(
                title: posts[index].title,
                onClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PostingPage(
                            communityInfo: community,
                            postId: posts[index].postId)),
                  );
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
}
