import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/posting_item.dart';
import 'package:flutter/material.dart';

class PostingPreviewPanel extends StatelessWidget {
  final String communityName;
  final List<PostingData> posts;
  final Function(String communityName, int postId)? onItemPressed;
  const PostingPreviewPanel({
    Key? key,
    required this.communityName,
    required this.posts,
    this.onItemPressed,
  }) : super(key: key);

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
                commentCount: posts[index].commentCount,
                onClick: () {
                  if (onItemPressed != null) {
                    onItemPressed!(communityName, posts[index].postId);
                  }
                  //
                  // locator<NavigationService>().navigateTo(
                  //     Routes.PostingPageRoute(
                  //         communityName, posts[index].postId));
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
