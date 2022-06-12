import 'package:cuteshrew/model/Post.dart';
import 'package:flutter/material.dart';

class PostingPanel extends StatelessWidget {
  final List<Post> posts;
  const PostingPanel({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: new BoxConstraints(minHeight: 500, maxHeight: 500),
      child: ListView.separated(
          itemCount: posts.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 30,
              child: Flexible(
                child: SelectableText(
                  posts[index].title,
                  toolbarOptions: ToolbarOptions(
                      copy: true, selectAll: true, cut: false, paste: false),
                  maxLines: 1,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(
              thickness: 1,
            );
          }),
    );
  }
}
