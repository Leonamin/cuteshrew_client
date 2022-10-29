import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/notifiers/posting_page_notifier.dart';
import 'package:cuteshrew/pages/community/community_page.dart';
import 'package:cuteshrew/pages/home/home_page.dart';
import 'package:cuteshrew/pages/post_editor/post_editor_page.dart';
import 'package:cuteshrew/pages/posting/comment_screen.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/states/posting_page_state.dart';
import 'package:cuteshrew/widgets/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class PostingScreen extends StatefulWidget {
  Community communityInfo;
  int postId;

  PostingScreen({Key? key, required this.communityInfo, required this.postId})
      : super(key: key);

  @override
  State<PostingScreen> createState() => _PostingScreenState();
}

class _PostingScreenState extends State<PostingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      return ChangeNotifierProvider(
        create: (context) {
          final notifier = PostingNotifier(
              postId: widget.postId,
              communityInfo: widget.communityInfo,
              api: context.read<CuteshrewApiClient>());
          notifier.getPosting();
          return notifier;
        },
        child: ProxyProvider<PostingNotifier, PostingPageState>(
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

  final LoginState loginState;

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
            return PasswordCertificationPostingPageScreen(state: state);
          }
          if (state is InvalidPasswordPostingPageState) {
            return PasswordCertificationPostingPageScreen(state: state);
          }
          if (state is DeletedDataPostingPageState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
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
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
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
  final LoginState loginState;

  // timestamp 초단위임
  String formatTimeStamp(int timeStamp) {
    DateTime postTime = DateTime.fromMillisecondsSinceEpoch(timeStamp * 1000);
    DateTime now = DateTime.now();
    final gap = now.difference(postTime);
    int currentTime = DateTime.now().millisecondsSinceEpoch;
    int timeGap = currentTime - timeStamp * 1000;

    /*
      1분 이내: x초 전
      1시간 이내: x분 전
      하루 이내: x시간 전
      3일 이내: x일 전
      이후: xxxx년 xx월 x일 
    */

    if (gap.inMinutes < 1) {
      return "${gap.inSeconds}초 전";
    }
    if (gap.inHours < 1) {
      return "${gap.inMinutes}분 전";
    }
    if (gap.inDays < 1) {
      return "${gap.inHours}시간 전";
    }
    if (gap.inDays < 4) {
      return "${gap.inDays}일 전";
    }
    return "${postTime.year.toString()}년 ${postTime.month.toString().padLeft(2, '0')}월 ${postTime.day.toString().padLeft(2, '0')}일";
  }

  Widget _makePostingHeader(context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // 소속 게시판
      GestureDetector(
        child: Row(
          children: [
            Text(
              postingPageState.communityInfo.communityShowName,
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CommunityPage(
                      communityInfo: postingPageState.communityInfo)));
        },
      ),
      const SizedBox(
        height: 5,
      ),
      // 제목
      Text(
        postingPageState.postDetail.title,
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
              Text(
                postingPageState.postDetail.userInfo.name,
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              Text(
                formatTimeStamp(postingPageState.postDetail.publishedAt),
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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostEditorPage(
                                      communityInfo:
                                          postingPageState.communityInfo,
                                      originPost: postingPageState.postDetail,
                                      isModify: true,
                                    )));
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
                        context.read<PostingNotifier>().deletePosting(token);
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
        Html(data: postingPageState.postDetail.body),
        const Divider(
          height: 5,
        ),
        Expanded(
          child: CommentScreen(
              communityInfo: postingPageState.communityInfo,
              postId: postingPageState.postId),
        ),
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

class PasswordCertificationPostingPageScreen extends StatelessWidget {
  PasswordCertificationPostingPageScreen({
    Key? key,
    required this.state,
  }) : super(key: key);

  final PostingPageState state;

  static const int _passwordLengthLimit = 20;
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.transparent, width: 0));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("잠긴 게시물입니다!"),
        TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(_passwordLengthLimit)
          ],
          textInputAction: TextInputAction.go,
          onFieldSubmitted: (value) {
            context.read<PostingNotifier>().getPosting(value);
          },
          cursorColor: Colors.white,
          controller: _passwordController,
          validator: (text) {
            if (text == null || text.isEmpty) {
              return "이거 비어있으면 안됨";
            }

            return null;
          },
          decoration: InputDecoration(
              labelText: "비밀번호",
              border: _border,
              errorBorder: _border,
              enabledBorder: _border,
              focusedBorder: _border,
              filled: true,
              fillColor: Colors.black54,
              errorStyle: const TextStyle(
                  color: Colors.redAccent, fontWeight: FontWeight.bold),
              labelStyle: const TextStyle(color: Colors.white)),
        )
      ],
    );
  }
}
