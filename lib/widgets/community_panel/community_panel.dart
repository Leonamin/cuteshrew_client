import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/model/Post.dart';
import 'package:flutter/material.dart';

class CommunityPanel extends StatefulWidget {
  final List<Community> community_info;
  CommunityPanel({Key? key, required this.community_info}) : super(key: key);

  @override
  State<CommunityPanel> createState() => _CommunityPanelState();
}

class _CommunityPanelState extends State<CommunityPanel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.community_info[0].communityName,
            style: TextStyle(
                fontSize: 30, fontWeight: FontWeight.w800, height: 0.9),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey,
          ),
          panel_item_builder(widget.community_info[0].latestPostingList)
        ],
      ),
    );
  }
}

Widget panel_item_builder(List<Post> posts) {
  return ConstrainedBox(
    constraints: new BoxConstraints(minHeight: 35, maxHeight: 150),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(left: 8, right: 8),
      itemCount: posts.length > 10 ? 10 : posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 30,
          // color: Colors.white,
          color: Colors.amber,
          child: Row(children: [
            Text(
              posts[index].title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            Icon(Icons.comment)
          ]),
        );
      },
    ),
  );
}
