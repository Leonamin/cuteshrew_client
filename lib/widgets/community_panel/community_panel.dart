import 'package:cuteshrew/model/Community.dart';
import 'package:cuteshrew/model/Post.dart';
import 'package:flutter/material.dart';

class CommunityPanel extends StatelessWidget {
  final List<Community> community_info;
  const CommunityPanel({Key? key, required this.community_info})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SelectableText(
            community_info[0].communityShowName,
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 30,
                fontWeight: FontWeight.w800,
                height: 0.9),
            toolbarOptions: ToolbarOptions(
                copy: true, selectAll: true, cut: false, paste: false),
            maxLines: 1,
          ),
          Divider(
            thickness: 3,
            color: Colors.grey,
          ),
          panel_item_builder(community_info[0].latestPostingList)
        ],
      ),
    );
  }
}

Widget panel_item_builder(List<Post> posts) {
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
              child: Column(
                children: [
                  Row(children: [
                    //FIXME Right Overflow 발생하므로 제한 필요
                    //그리고 드래그하면 개별적으로 드래그가 유지되기 때문에 각 뷰에다가 직접 터치를 해야 드래그가 사라짐
                    Flexible(
                      child: SelectableText(
                        posts[index].title,
                        toolbarOptions: ToolbarOptions(
                            copy: true,
                            selectAll: true,
                            cut: false,
                            paste: false),
                        maxLines: 1,
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Flexible(child: Icon(Icons.comment)),
                  ]),
                ],
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
            );
          }));
}
