import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/circle_user_icon.dart';
import 'package:flutter/material.dart';

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

  Widget _header() {
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

  Widget _bottom() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(),
        Row(
          children: [
            OutlinedButton(
                onPressed: () {},
                child: Text("취소",
                    style: TextStyle(
                        fontSize: 14, color: Colors.black.withOpacity(0.8)))),
            const SizedBox(
              width: 8,
            ),
            ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[100]),
                child: Text(
                  "등록",
                  style: TextStyle(fontSize: 14, color: Colors.green[500]),
                ))
          ],
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            _header(),
            _body(),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 4),
              child: Divider(
                thickness: 1,
              ),
            ),
            _bottom(),
          ],
        ),
      ),
    );
  }
}
