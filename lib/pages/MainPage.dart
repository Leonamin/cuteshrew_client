import 'package:cuteshrew/model/Post.dart';
import 'package:cuteshrew/pages/CommunityPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  static const String route = '/main';

  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Post> posts = [Post(0, "title")];

  @override
  void initState() {
    super.initState();
    _requestCommunities();
  }

  _requestCommunities() async {
    posts.add(Post(0, "asdad"));
  }

  @override
  Widget build(BuildContext context) {
    var postTitleTextStyle =
        const TextStyle(color: Colors.black, fontFamily: 'GyeonggiLight');

    var communityTitleStyle = TextStyle(
      color: Colors.blue[900],
      fontSize: 20,
    );

    var generalCommunityTitle = TextSpan(
      text: "자유게시판",
      style: communityTitleStyle,
      recognizer: TapGestureRecognizer()
      ..onTap = () {
        Navigator.pushNamed(context, CommunityPage.route);
      },
    );

    var generalCommunityList = ListView.separated(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          child: Text(posts[index].title, style: postTitleTextStyle),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider();
      },
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          "Cute Shrew",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {}, icon: const Icon(Icons.view_headline_rounded)),
        actions: [],
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        alignment: Alignment.topCenter,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              padding: const EdgeInsets.only(bottom: 10),
              child: RichText(text: generalCommunityTitle,)),
          SizedBox(
            height: 200,
            child: generalCommunityList,
          )
        ]),
      ),
    );
  }
}
