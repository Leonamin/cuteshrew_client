import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/community_page.dart';
import 'package:cuteshrew/pages/posting_page.dart';
import 'package:cuteshrew/widgets/community_title/community_title.dart';
import 'package:cuteshrew/widgets/posting_item/posting_item.dart';
import 'package:flutter/material.dart';

class CommunityPanel extends StatelessWidget {
  final Community community_info;
  const CommunityPanel({Key? key, required this.community_info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CommunityTitle(
              title: community_info.communityShowName,
              onClick: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          CommunityPage(community: community_info)),
                );
              }),
          Divider(
            thickness: 3,
            color: Colors.grey,
          ),
          panel_item_builder(community_info)
        ],
      ),
    );
  }
}

Widget panel_item_builder(Community community) {
  List<Post> posts = community.latestPostingList;
  return ConstrainedBox(
      constraints: new BoxConstraints(minHeight: 300, maxHeight: 300),
      child: ListView.separated(
          scrollDirection: Axis.vertical,
          itemCount: posts.length > 10 ? 10 : posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 30,
                // color: Colors.white,
                // color: Colors.amber,
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
            return Divider(
              thickness: 1,
            );
          }));
}
