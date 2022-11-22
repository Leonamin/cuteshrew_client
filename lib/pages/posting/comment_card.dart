import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_detail.dart';
import 'package:cuteshrew/providers/comment_editor_provider.dart';
import 'package:cuteshrew/providers/comment_page_notifier.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/states/comment_page_state.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  CommentCard(
      {super.key,
      required this.communityInfo,
      required this.postId,
      required this.comment});

  Community communityInfo;
  int postId;
  CommentDetail comment;

  int voteCount = 0;

  SnackBar _makeSnackBar(String content, [Color? backgroundColor]) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
    );
  }

  Card _header(BuildContext context) {
    return Card(
      color: Colors.grey[300],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // 프로필 사진, 닉네임
          Row(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
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
                width: 4,
              ),
              InkWell(
                onTap: () => Navigator.pushNamed(
                    context, Routes.UserPageRoute(comment.userInfo.name)),
                child: Text(
                  comment.userInfo.name,
                  style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              )
            ],
          ),
          // 시간
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Text(
              Utils.formatTimeStamp(comment.createdAt),
              style:
                  TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  String formatVoteCount(int voteCount) {
    final trillion = 1000000000000;
    final billion = 1000000000;
    final million = 1000000;
    final kilo = 1000;

    if (voteCount >= trillion) {
      return "999+b";
    }
    if (voteCount >= billion) {
      return "${(voteCount / billion).toStringAsFixed(1)}b";
    }
    if (voteCount >= million) {
      return "${(voteCount / million).toStringAsFixed(1)}m";
    }
    if (voteCount >= kilo) {
      return "${(voteCount / kilo).toStringAsFixed(1)}k";
    }

    return voteCount.toString();
  }

  void _checkCommentState(CommentEdiorState state,
      CommentPageState commentPageState, BuildContext context) {
    if (state == CommentEdiorState.COMPLETED) {
      // FIXME 만약 현재 페이지가 마지막이고 댓글을 지울경우 페이지가 사라지는 경우 예외처리 필요
      context
          .read<CommentPageNotifier>()
          .getCommentPage(commentPageState.currentPageNum);
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("댓글 삭제 완료"));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("댓글 삭제 실패"));
    }
  }

  void _deleteComment(LoginState loginState, CommentPageState commentPageState,
      BuildContext context) {
    if (loginState is AuthorizedState) {
      context
          .read<CommentEditorProvider>()
          .deleteComment(communityInfo.communityName, loginState.loginToken,
              postId, comment.commentId)
          .then(
              (value) => _checkCommentState(value, commentPageState, context));
    } else {
      // Stateless에서는 인자를 주지 않으면 Undefined name 'context'가 발생한다.
      // Stateful에서는 인자를 안줘도 해당 오류가 발생하지 않는다.
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("로그인이 필요함"));
    }
  }

  Widget _bottom(LoginState loginState, CommentPageState commentPageState,
      BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>
          CommentEditorProvider(api: context.read<CuteshrewApiClient>()),
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.green),
                onPressed: () {},
                icon: const Icon(Icons.thumb_up_alt_rounded),
                label: Text(formatVoteCount(voteCount))),
            TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                onPressed: () {},
                icon: const Icon(
                  Icons.thumb_down_rounded,
                ),
                label: Text(formatVoteCount(voteCount))),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.grey),
              onPressed: () {},
              icon: const Icon(
                Icons.add_comment,
              ),
              label: const Text("답글"),
            ),
            // TODO 공간부족
            // TextButton.icon(
            //   style: TextButton.styleFrom(foregroundColor: Colors.grey),
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.share,
            //   ),
            //   label: const Text("공유"),
            // ),
            // TextButton.icon(
            //   style: TextButton.styleFrom(foregroundColor: Colors.grey),
            //   onPressed: () {},
            //   icon: const Icon(
            //     Icons.edit,
            //   ),
            //   label: const Text("수정"),
            // ),
            TextButton.icon(
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              onPressed: () {
                _deleteComment(loginState, commentPageState, context);
              },
              icon: const Icon(
                Icons.delete,
              ),
              label: const Text("삭제"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(
      builder: (context, loginState, child) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _header(context),
            const SizedBox(
              height: 4,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                comment.comment,
                style: const TextStyle(color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 4,
            ),
            Consumer<CommentPageState>(
              builder: (context, commentPageState, child) {
                return _bottom(loginState, commentPageState, context);
              },
            ),
          ],
        );
      },
    );
  }
}
