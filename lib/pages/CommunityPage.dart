import 'package:cuteshrew/pages/PostPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/model/Post.dart';

class CommunityPage extends StatefulWidget {
  static const String route = '/community';

  const CommunityPage({Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  List<Post> posts = [Post(0, "나는 폭군")];

  //
  int postNumberOnCommunity = 10;

  // Display posts based on countPerPage
  // it can be changed by a filter
  int countPerPage = 15;

  @override
  void initState() {
    super.initState();
    _requestCommunities(0, 15);
  }

  _requestCommunities(int pageNum, int countPerPage) async {
    posts.add(Post(1, "티라노 사우어"));
  }

  @override
  Widget build(BuildContext context) {
    var postListTextStyle = const TextStyle(
        color: Colors.black, fontFamily: 'GyeonggiLight', fontSize: 20);

    var postList = ListView.separated(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: RichText(
            text: TextSpan(
                text: posts[index].title,
                style: postListTextStyle,
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) =>
                            PostPage(postId: posts[index].postId)));
                  }),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("자유게시판"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 500,
          child: postList,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.pushNamed(context, '/writing');
          },
          label: const Text('글쓰기'),
          icon: const Icon(Icons.post_add),
        ),
      ),
    );
  }
}
