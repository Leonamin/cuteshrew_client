import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:cuteshrew/strings/strings.dart';
import 'package:cuteshrew/widgets/clickable_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:cuteshrew/services/navigation_service.dart';

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
          const SizedBox(
            height: 30.0,
          ),
          FutureBuilder(
              future:
                  httpService.getPosting(_communityInfo.communityName, _postId),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  Map<String, dynamic> youMustDeleteThis =
                      snapshot.data as Map<String, dynamic>;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: ((context.select((LoginProvider login) =>
                                    login.loginToken)) ==
                                null)
                            ? null
                            : buildToolTab(context, _communityInfo,
                                youMustDeleteThis['data'] as PostDetail),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ClickableText(
                          text: _communityInfo.communityShowName,
                          size: 30,
                          weight: FontWeight.w800,
                          onClick: () {
                            locator<NavigationService>()
                                .pushNamed(CommunityPageRoute, arguments: {
                              'communityInfo': _communityInfo,
                            });
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Html(
                        data: youMustDeleteThis['data'].body,
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
            locator<NavigationService>().pushNamed(PostEditorPageRoute,
                arguments: {
                  'communityInfo': communityInfo,
                  'postDetail': postDetail,
                  'isModify': true
                });
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
                              Navigator.pop(context),
                              locator<NavigationService>().pushNamed(
                                  CommunityHomePageRoute,
                                  arguments: {'communityInfo': _communityInfo})
                            }
                          else
                            {
                              Navigator.pop(context),
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
