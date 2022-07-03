import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/posting_page.dart';
import 'package:cuteshrew/provider/page_notifier.dart';
import 'package:cuteshrew/widgets/posting_item/posting_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostingPanel extends StatelessWidget {
  final Community community;
  final List<Post> posts;
  const PostingPanel({Key? key, required this.community, required this.posts})
      : super(key: key);

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
                onClick: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //       builder: (context) => PostingPage({
                  //             'communityInfo': community,
                  //             'postId': posts[index].postId
                  //           })),
                  // );
                  Provider.of<PageNotifier>(context, listen: false).goToPage(
                      PostingPage.pageName, {
                    'communityInfo': community,
                    'postId': posts[index].postId
                  });
                },
              ));
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 1,
          );
        });
  }
}
