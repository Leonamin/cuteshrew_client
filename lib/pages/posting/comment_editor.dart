import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_create.dart';
import 'package:cuteshrew/pages/posting/posting_page.dart';
import 'package:cuteshrew/providers/comment_editor_provider.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/circle_user_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentEditor extends StatefulWidget {
  Community communityInfo;
  int postId;
  CommentEditor({
    super.key,
    required this.communityInfo,
    required this.postId,
  });

  @override
  State<CommentEditor> createState() => _CommentEditorState();
}

class _CommentEditorState extends State<CommentEditor> {
  int _currentBytes = 0;

  TextEditingController _commentController = TextEditingController();

  SnackBar _makeSnackBar(String content, [Color? backgroundColor]) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
    );
  }

  void _checkCommentState(CommentEdiorState state) {
    if (state == CommentEdiorState.COMPLETED) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostingPage(
                communityInfo: widget.communityInfo, postId: widget.postId),
          ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("댓글 업로드 실패"));
    }
  }

  void _sendComment(LoginState loginState, CommentEditorProvider provider) {
    if (loginState is AuthorizedState) {
      if (_commentController.text.isEmpty) {
        ScaffoldMessenger.of(context)
            .showSnackBar(_makeSnackBar("댓글 내용이 비었습니다."));
        return;
      }
      CommentCreate newComment =
          CommentCreate(comment: _commentController.text);
      provider
          .uploadComment(widget.communityInfo.communityName,
              loginState.loginToken, widget.postId, newComment)
          .then((state) => _checkCommentState(state));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("로그인이 필요합니다."));
    }
  }

  Widget _header(loginState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleUserIcon(
                child: const Icon(
              Icons.person_outline,
              color: dark,
            )),
            const SizedBox(
              width: 4,
            ),
            //FIXME LoginToken에는 유저 정보가 없다! 그래서 유저 이름을 넣을 수가 없네!
            Text(
              "User",
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
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
                ElevatedButton(
                    onPressed: () {
                      _sendComment(loginState, value);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[100]),
                    child: Text(
                      "등록",
                      style: TextStyle(fontSize: 14, color: Colors.green[500]),
                    ))
              ],
            );
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (context, loginState, child) {
        return ChangeNotifierProvider(
          create: (context) =>
              CommentEditorProvider(api: context.read<CuteshrewApiClient>()),
          builder: (context, child) => Card(
            color: Colors.grey[200],
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  _header(loginState),
                  _body(),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 4),
                    child: Divider(
                      thickness: 1,
                    ),
                  ),
                  _bottom(loginState),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
