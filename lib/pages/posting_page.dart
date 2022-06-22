import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class PostingPage extends StatefulWidget {
  static const pageName = '/post';

  final Map<String, dynamic> _arguments;

  const PostingPage(this._arguments, {Key? key}) : super(key: key);

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
    Community communityInfo = widget._arguments['communityInfo'] as Community;
    int postId = widget._arguments['postId'] as int;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const MainNavigationBar(),
          FutureBuilder(
              future:
                  httpService.getPosting(communityInfo.communityName, postId),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ((context.select((LoginProvider login) =>
                                    login.loginToken)) ==
                                null)
                            ? null
                            : buildToolTab(context, communityInfo,
                                snapshot.data as PostDetail),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                height: 0.9),
                            communityInfo.communityShowName),
                      ),
                      Html(
                        data: (snapshot.data as PostDetail).body,
                      )
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return const CircularProgressIndicator();
              }))
        ],
      ),
    );
  }

  Widget buildToolTab(BuildContext context, communityInfo, postDetail) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      OutlinedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PostEditorPage({
                        'communityInfo': communityInfo,
                        'postDetail': postDetail,
                        'isModify': true
                      })),
            );
          },
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(
                width: 5,
              ),
              Text("수정")
            ],
          )),
      ElevatedButton(
          onPressed: () {},
          //TODO 나중에 버튼 색상 좀...
          child: Row(
            children: const [
              Icon(Icons.delete_forever),
              SizedBox(
                width: 5,
              ),
              Text("삭제")
            ],
          ))
    ]);
  }
}
