import 'package:flutter/material.dart';
import 'package:cuteshrew/model/Post.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

class PostPage extends StatefulWidget {
  static const String baseRoute = '/posts';

  const PostPage({Key? key, required this.postId}) : super(key: key);

  final int postId;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  var post = "";

  @override
  void initState() {

    super.initState();
    _requestPost(widget.postId);
  }

  _requestPost(int postId) async {
    setState(() {
      // test
      switch(postId) {
        case 0:
          this.post = "파키케팔로사우어";
          break;
        case 1:
          this.post = "나는 사실 트리케라톱스";
          break;
        default:
          this.post = "그래 티라노";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var postListTextStyle = const TextStyle(
        color: Colors.black, fontFamily: 'GyeonggiLight', fontSize: 20);

    var post = new Center(
      child: SingleChildScrollView(
        child: Html(
          data: this.post,
          padding: EdgeInsets.all(8.0),
          onLinkTap: (url) {
            print("Opening $url...");
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("자유게시판"),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: SizedBox(
          width: 500,
          child: post,
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 50.0),
        child: FloatingActionButton.extended(
          onPressed: () {Navigator.pushNamed(context, '/writing');},
          label: const Text('글쓰기'),
          icon: const Icon(Icons.post_add),
        ),
      ),
    );
  }
}
