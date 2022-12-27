import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/old/pages/posting/posting_screen/password_certification_posting_page_screen.dart';
import 'package:cuteshrew/presentation/screens/posting/providers/posting_page_provider.dart';
import 'package:cuteshrew/old/pages/post_editor/post_editor_page.dart';
import 'package:cuteshrew/presentation/screens/comment/comment_screen.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/screens/posting/providers/posting_page_state.dart';
import 'package:cuteshrew/old/utils/utils.dart';
import 'package:cuteshrew/widgets/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class PostingScreen extends StatefulWidget {
  String communityName;
  int postId;

  PostingScreen({Key? key, required this.communityName, required this.postId})
      : super(key: key);

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(builder: (context, loginState, child) {
      return ChangeNotifierProvider(
        create: (context) {
          final notifier = PostingPageProvider(
              postId: widget.postId,
              communityName: Community(
                  communityName: widget.communityName,
                  communityShowName: widget.communityName,
                  latestPostingList: [],
                  postingsCount: 0),
              api: context.read<CuteshrewApiClient>());
          notifier.getPosting();
          return notifier;
        },
        child: ProxyProvider<PostingPageProvider, PostingPageState>(
          update: (context, value, previous) => value.value,
          child: PostingPageScreen(
            loginState: loginState,
          ),
        ),
      );
    });
  }
}

class PostingPageScreen extends StatelessWidget {
  const PostingPageScreen({Key? key, required this.loginState})
      : super(key: key);

  final AuthenticationState loginState;

  @override
  Widget build(BuildContext context) {
    return Consumer<PostingPageState>(builder: (context, state, child) {
      return Scaffold(
        body: () {
          if (state is NotLoadedPostingPageState ||
              state is LoadingPostingPageState) {
            return Container();
          }
          if (state is LoadedDataPostingPageState) {
            return LoadedDataPostingPageScreen(
              postingPageState: state,
              loginState: loginState,
            );
          }
          if (state is NeedPasswordPostingPageState) {
            return PasswordCertificationPostingPageScreen(
                postingPageState: state);
          }
          if (state is DeletedDataPostingPageState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.pushNamed(context, Routes.HomePageRoute);
            });
          }
          if (state is UnknownErrorPostingPageState) {}
          return const NoDataPostingPageScreen();
        }(),
      );
    });
  }
}

class NoDataPostingPageScreen extends StatelessWidget {
  const NoDataPostingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text("데이터가 없습니다."),
          const SizedBox(height: 24),
          ClickableText(
            text: "홈으로 돌아가기",
            onClick: () {
              Navigator.pushNamed(context, Routes.HomePageRoute);
            },
          )
        ],
      ),
    );
  }
}

class LoadingPostingPageScreen extends StatelessWidget {
  const LoadingPostingPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoadedDataPostingPageScreen extends StatelessWidget {
  const LoadedDataPostingPageScreen({
    Key? key,
    required this.postingPageState,
    required this.loginState,
  }) : super(key: key);

  final LoadedDataPostingPageState postingPageState;
  final AuthenticationState loginState;

  Widget _makePostingHeader(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // 소속 게시판
      GestureDetector(
        child: Row(
          children: [
            Text(
              postingPageState._postDetail.ownCommunity.communityShowName,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.w100,
              ),
            ),
            const Icon(
              Icons.arrow_right,
              color: Colors.blue,
            ),
          ],
        ),
        onTap: () {
          Navigator.pushNamed(
              context,
              Routes.CommuintyNamePageRoute(
                  postingPageState.communityName.communityName));
        },
      ),
      const SizedBox(
        height: 5,
      ),
      // 제목
      Text(
        postingPageState._postDetail.title,
        style: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: const CircleAvatar(
                    backgroundColor: light,
                    child: Icon(
                      Icons.person_outline,
                      color: dark,
                    ))),
          ),
          const SizedBox(
            width: 5,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () => Navigator.pushNamed(
                    context,
                    Routes.UserPageRoute(
                        postingPageState._postDetail.userInfo.name)),
                child: Text(
                  postingPageState._postDetail.userInfo.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Text(
                Utils.formatTimeStamp(postingPageState._postDetail.publishedAt),
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8), fontSize: 14),
              )
            ],
          )
        ],
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final LoginToken? token = loginState is AuthorizedState
        ? (loginState as AuthorizedState).loginToken
        : null;
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
      children: [
        _makePostingHeader(context),
        const SizedBox(
          height: 10,
        ),
        // 툴바
        Container(
          child: token != null
              ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          textStyle: const TextStyle(color: Colors.black)),
                      onPressed: () {
                        Navigator.pushNamed(
                            context,
                            Routes.PostEditorPageRoute(
                                postingPageState.communityName.communityName),
                            arguments: PostEditorPageArguments(
                                postingPageState._postDetail, true));
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
                  const SizedBox(
                    width: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        textStyle: const TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        //TODO 임시로
                        // _showDialog(context, loginState);
                        context
                            .read<PostingPageProvider>()
                            .deletePosting(token);
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.delete_forever),
                          SizedBox(
                            width: 5,
                          ),
                          Text("삭제")
                        ],
                      ))
                ])
              : null,
        ),
        const Divider(
          height: 5,
        ),
        Html(data: postingPageState._postDetail.body),
        const Divider(
          height: 5,
        ),
        // Expanded 위젯은 Column, Row, Flex 내에서만 사용 가능하다.
        CommentScreen(
            communityInfo: postingPageState.communityName,
            postId: postingPageState.postId),
      ],
    );
  }

  //FIXME provider 못찾는 문제

  // void _showDialog(BuildContext context, LoginState loginState) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text(Strings.alretDeletePostingTitle),
  //         content: const Text(Strings.alretDeletePostingBody),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text(Strings.alretAccept),
  //             onPressed: () {
  //               if (loginState is AuthorizedState) {
  //                 context
  //                     .read<PostingNotifier>()
  //                     .deletePosting(loginState.loginToken);
  //               }
  //             },
  //           ),
  //           TextButton(
  //             child: const Text(Strings.alretBack),
  //             onPressed: () {
  //               Navigator.pop(context);
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
