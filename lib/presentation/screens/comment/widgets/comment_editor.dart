import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/core/data/datasource/remote/comment_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/comment_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/create_comment_usecase.dart';
import 'package:cuteshrew/presentation/data/comment_create_data.dart';
import 'package:cuteshrew/presentation/screens/comment_editor/provider/comment_editor_provider.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_provider.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_state.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/circle_user_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// TODO CommentEditor는 독립적으로 동작 불가
// CommentProvider에 종속되어 있다.
// 등록 버튼을 눌렀을 떄 할 메소드를 인자로 받아서 처리하는게 나을지도 모른다.
class CommentEditor extends StatefulWidget {
  final String communityName;
  final int postId;
  const CommentEditor({
    super.key,
    required this.communityName,
    required this.postId,
  });

  @override
  State<CommentEditor> createState() => _CommentEditorState();
}

class _CommentEditorState extends State<CommentEditor> {
  int _currentBytes = 0;

  final TextEditingController _commentController = TextEditingController();

  SnackBar _makeSnackBar(String content, [Color? backgroundColor]) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
    );
  }

  void _checkCommentState(
      CommentEdiorState state, CommentPageState commentPageState) {
    if (state == CommentEdiorState.COMPLETED) {
      context
          .read<CommentPageProvider>()
          .getCommentPage(commentPageState.currentPageNum);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("댓글 업로드 실패"));
    }
  }

  void _sendComment(AuthenticationState loginState,
      CommentPageState commentPageState, CommentEditorProvider provider) {
    if (loginState is AuthorizedState) {
      if (_commentController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(_makeSnackBar("댓글 내용이 비었습니다."));
        return;
      }
      final newComment = CommentCreateData(comment: _commentController.text);
      provider
          .uploadComment(widget.communityName, loginState.loginToken,
              widget.postId, newComment)
          .then((state) => _checkCommentState(state, commentPageState));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("로그인이 필요합니다."));
    }
  }

  // 위젯을 메소드로 호출하면 플러터의 빌드 자체 최적화가 안된다.
  /*
  Widget _header(loginState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            // TODO 유저 프로필 사진
            CircleUserIcon(
                child: Icon(
              Icons.person_outline,
              color: dark,
            )),
            const SizedBox(
              width: 4,
            ),
            Text(
              (loginState is AuthorizedState) ? loginState.userName : "User",
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        Text("$_currentBytes/$maxCommentBytes"),
      ],
    );
  }

  Widget _body() {
    return TextField(
      controller: _commentController,
      maxLength: maxCommentBytes,
      minLines: 1,
      maxLines: 8,
      onChanged: (value) {
        setState(() {
          _currentBytes = value.length;
        });
      },
      decoration:
          const InputDecoration(counterText: "", hintText: "댓글을 작성해보세요"),
    );
  }

  Widget _bottom(loginState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Consumer<CommentEditorProvider>(
          builder: (context, value, child) {
            return Row(
              children: [
                OutlinedButton(
                    onPressed: () {},
                    child: Text("취소",
                        style: TextStyle(
                            fontSize: 14,
                            color: Colors.black.withOpacity(0.8)))),
                const SizedBox(
                  width: 8,
                ),
                Consumer<CommentPageState>(
                  builder: (context, commentPageState, child) {
                    return ElevatedButton(
                        onPressed: () {
                          _sendComment(loginState, commentPageState, value);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[100]),
                        child: Text(
                          "등록",
                          style:
                              TextStyle(fontSize: 14, color: Colors.green[500]),
                        ));
                  },
                )
              ],
            );
          },
        )
      ],
    );
  }
  */

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(
      builder: (context, loginState, child) {
        return ChangeNotifierProvider(
          create: (context) => CommentEditorProvider(
            useCase: CreateCommentUseCase(
              commentRepository: CommentRepositoryImpl(
                commentRemoteDatasource: CommentRemoteDataSource(),
              ),
            ),
          ),
          builder: (context, child) => Card(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // 헤더부 유저 프로필, 이름, 날짜
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          // TODO 유저 프로필 사진
                          CircleUserIcon(
                              child: Icon(
                            Icons.person_outline,
                            color: dark,
                          )),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            (loginState is AuthorizedState)
                                ? loginState.userName
                                : "User",
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Text("$_currentBytes/$maxCommentBytes"),
                    ],
                  ),
                  // 중단부 댓글 입력창
                  TextField(
                    controller: _commentController,
                    maxLength: maxCommentBytes,
                    minLines: 1,
                    maxLines: 8,
                    onChanged: (value) {
                      setState(() {
                        _currentBytes = value.length;
                      });
                    },
                    decoration: const InputDecoration(
                        counterText: "", hintText: "댓글을 작성해보세요"),
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  // 하단부 취소, 등록버튼
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(),
                      Consumer<CommentEditorProvider>(
                        builder: (context, value, child) {
                          return Row(
                            children: [
                              OutlinedButton(
                                  onPressed: () {},
                                  child: Text("취소",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:
                                              Colors.black.withOpacity(0.8)))),
                              const SizedBox(
                                width: 8,
                              ),
                              Consumer<CommentPageState>(
                                builder: (context, commentPageState, child) {
                                  return ElevatedButton(
                                      onPressed: () {
                                        _sendComment(loginState,
                                            commentPageState, value);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green[100]),
                                      child: Text(
                                        "등록",
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: Colors.green[500]),
                                      ));
                                },
                              )
                            ],
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
