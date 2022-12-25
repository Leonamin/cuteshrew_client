// class PostingPanel extends StatelessWidget {
//   final Community community;
//   final List<Post> posts;
//   const PostingPanel({Key? key, required this.community, required this.posts})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.separated(
//         physics: const NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: posts.length,
//         itemBuilder: (BuildContext context, int index) {
//           return SizedBox(
//               height: 30,
//               child: PostingItem(
//                 posting: posts[index],
//                 onClick: () {
//                   Navigator.pushNamed(
//                       context,
//                       Routes.PostingPageRoute(
//                           community.communityName, posts[index].postId));
//                 },
//               ));
//         },
//         separatorBuilder: (BuildContext context, int index) {
//           return const Divider(
//             thickness: 1,
//           );
//         });
//   }
// }
