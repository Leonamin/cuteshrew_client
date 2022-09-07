import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/login_token.dart';
import 'package:cuteshrew/notifiers/posting_page_notifier.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/states/posting_page_state.dart';
import 'package:cuteshrew/strings/strings.dart';
import 'package:cuteshrew/widgets/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late Community _communityInfo;
  late int _postId;

  @override
  void initState() {
    super.initState();
    _communityInfo = widget._arguments['communityInfo'] as Community;
    _postId = widget._arguments['postId'] as int;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, loginState, child) {
      return ChangeNotifierProvider(
        create: (context) {
          final notifier = PostingNotifier(
              postId: _postId,
              communityInfo: _communityInfo,
              api: context.read<CuteshrewApiClient>());
          notifier.getPosting();
          return notifier;
        },
        child: ProxyProvider<PostingNotifier, PostingPageState>(
          update: (context, value, previous) => value.value,
          child: PostingPageLayout(
            loginState: loginState,
          ),
        ),
      );
    });
  }
}

class PostingPageLayout extends StatelessWidget {
  const PostingPageLayout({Key? key, required this.loginState})
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
            return LoadedDataPostingPageLayout(
              postingPageState: state,
              loginState: loginState,
            );
          }
          if (state is NeedPasswordPostingPageState) {
            return PasswordCertificationPostingPageLayout(state: state);
          }
          if (state is InvalidPasswordPostingPageState) {
            return PasswordCertificationPostingPageLayout(state: state);
          }
          if (state is DeletedDataPostingPageState) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              locator<NavigationService>().pushNamed(CommunityHomePageRoute);
            });
          }
          if (state is UnknownErrorPostingPageState) {}
          return const NoDataPostingPageLayout();
        }(),
      );
    });
  }
}

class NoDataPostingPageLayout extends StatelessWidget {
  const NoDataPostingPageLayout({Key? key}) : super(key: key);

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
              locator<NavigationService>().pushNamed(CommunityHomePageRoute);
            },
          )
        ],
      ),
    );
  }
}

class LoadingPostingPageLayout extends StatelessWidget {
  const LoadingPostingPageLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class LoadedDataPostingPageLayout extends StatelessWidget {
  const LoadedDataPostingPageLayout({
    Key? key,
    required this.postingPageState,
    required this.loginState,
  }) : super(key: key);

  final LoadedDataPostingPageState postingPageState;
  final LoginState loginState;

  @override
  Widget build(BuildContext context) {
    final LoginToken? token = loginState is AuthorizedState
        ? (loginState as AuthorizedState).loginToken
        : null;
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: ClickableText(
            text: postingPageState.communityInfo.communityShowName,
            size: 30,
            weight: FontWeight.w800,
            onClick: () {
              locator<NavigationService>()
                  .pushNamed(CommunityPageRoute, arguments: {
                'communityInfo': postingPageState.communityInfo,
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          child: token != null
              ? Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  OutlinedButton(
                      onPressed: () {
                        locator<NavigationService>()
                            .pushNamed(PostEditorPageRoute, arguments: {
                          'communityInfo': postingPageState.communityInfo,
                          'postDetail': postingPageState.postDetail,
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
        const SizedBox(
          height: 10,
        ),
        Html(data: postingPageState.postDetail.body)
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

class PasswordCertificationPostingPageLayout extends StatelessWidget {
  PasswordCertificationPostingPageLayout({
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
