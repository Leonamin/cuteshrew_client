import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/pages/community_page.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/strings/strings.dart';
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
  HttpService httpService = HttpService();
  late Community _communityInfo;
  late int _postId;
  late LoginToken? _token;

  @override
  void initState() {
    super.initState();
    _communityInfo = widget._arguments['communityInfo'] as Community;
    _postId = widget._arguments['postId'] as int;
  }

  @override
  Widget build(BuildContext context) {
    //TODO 이게 정말 최선의 방법일까
    _token = context.read<LoginProvider>().loginToken;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          FutureBuilder(
              future:
                  httpService.getPosting(_communityInfo.communityName, _postId),
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
                            : buildToolTab(context, _communityInfo,
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
                            _communityInfo.communityShowName),
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
          onPressed: () {
            _showDialog(context);
          },
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

  //TODO 나중에 삭제점
  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(Strings.alretDeletePostingTitle),
          content: const Text(Strings.alretDeletePostingBody),
          actions: <Widget>[
            TextButton(
              child: const Text(Strings.alretAccept),
              onPressed: () {
                httpService
                    .deletePosting(
                        _communityInfo.communityName, _token!, _postId)
                    .then((value) => {
                          if (value)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CommunityPage(
                                        {'communityInfo': _communityInfo})),
                              )
                            }
                          else
                            {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(Strings.alarmDeletePostingFailed),
                              ))
                            }
                        });
              },
            ),
            TextButton(
              child: const Text(Strings.alretBack),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
