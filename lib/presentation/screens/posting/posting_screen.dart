import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/core/data/datasource/remote/comment_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/comment_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/usecase/show_posting_page_usecase.dart';
import 'package:cuteshrew/presentation/screens/posting_editor/posting_editor_page.dart';
import 'package:cuteshrew/presentation/screens/posting/posting_screen/password_certification_posting_page_screen.dart';
import 'package:cuteshrew/presentation/screens/posting/providers/posting_page_provider.dart';
import 'package:cuteshrew/presentation/screens/comment/comment_screen.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/screens/posting/providers/posting_page_state.dart';
import 'package:cuteshrew/presentation/strings/strings.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';

class PostingScreen extends StatefulWidget {
  final String communityName;
  final int postId;

  const PostingScreen(
      {Key? key, required this.communityName, required this.postId})
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
            postingPageUseCase: ShowPostingPageUseCase(
              postingRepository: PostingRepositoryImpl(
                postingRemoteDataSource: PostingRemoteDataSource(),
              ),
              commentRepository: CommentRepositoryImpl(
                commentRemoteDatasource: CommentRemoteDataSource(),
              ),
            ),
            postId: widget.postId,
            communityName: widget.communityName,
          );
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
              context.read<PostingPageProvider>().navigateToHome();
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
              context.read<PostingPageProvider>().navigateToHome();
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

  Widget _makePostingHeader(PostingPageProvider provider) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // 소속 게시판
      GestureDetector(
        child: Row(
          children: [
            Text(
              postingPageState.communityShowName,
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
          provider.navigateToCommunity(postingPageState.communityName);
        },
      ),
      const SizedBox(
        height: 8,
      ),
      // 제목
      Text(
        postingPageState.title,
        style: const TextStyle(
            color: Colors.black, fontSize: 30, fontWeight: FontWeight.bold),
      ),
      const SizedBox(
        height: 8,
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
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: () {
                  provider.navigateToUser(postingPageState.writerName);
                },
                child: Text(
                  postingPageState.writerName,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ),
              Text(
                postingPageState.publishedDateTime,
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
    final LoginTokenEntity? token = loginState is AuthorizedState
        ? (loginState as AuthorizedState).loginToken
        : null;
    return Consumer<PostingPageProvider>(
      builder: (context, provider, child) => ListView(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        children: [
          _makePostingHeader(provider),
          const SizedBox(
            height: 12,
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
                          provider.navigateToPostingEditor(
                              postingPageState.communityName,
                              PostEditorPageArguments(
                                  postingPageState.postingDetailData, true));
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
                      width: 12,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        textStyle: const TextStyle(color: Colors.black),
                      ),
                      onPressed: () {
                        _showDialog(
                          context,
                          () => provider.deletePosting(token),
                          () => provider.goBack(),
                        );
                      },
                      child: Row(
                        children: const [
                          Icon(Icons.delete_forever),
                          SizedBox(
                            width: 8,
                          ),
                          Text("삭제")
                        ],
                      ),
                    )
                  ])
                : null,
          ),
          const Divider(
            height: 8,
          ),
          // SelectableHtml 쓰면 이미지가 출력이 안된다.
          Html(
            data: postingPageState.content,
            onLinkTap: (url, context, attributes, element) {},
          ),
          const Divider(
            height: 8,
          ),
          // Expanded 위젯은 Column, Row, Flex 내에서만 사용 가능하다.
          CommentScreen(
              communityName: postingPageState.communityName,
              postId: postingPageState.postId),
        ],
      ),
    );
  }

  void _showDialog(
    BuildContext context,
    Function()? onDeletePressed,
    Function()? onBackPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(Strings.alretDeletePostingTitle),
          content: const Text(Strings.alretDeletePostingBody),
          actions: [
            TextButton(
              onPressed: onDeletePressed,
              child: const Text(Strings.alretAccept),
            ),
            TextButton(
              onPressed: onBackPressed,
              child: const Text(Strings.alretBack),
            ),
          ],
        );
      },
    );
  }
}
