import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/widgets/posting_item/posting_item.dart';
import 'package:flutter/material.dart';

class PostingPanel extends StatelessWidget {
  final List<Post> posts;
  const PostingPanel({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          return SizedBox(
              height: 30,
              child: PostingItem(
                title: posts[index].title,
                onClick: () {},
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 1,
          );
        });
  }
}
