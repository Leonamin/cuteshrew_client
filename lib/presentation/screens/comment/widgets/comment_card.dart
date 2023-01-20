import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_provider.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_state.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatelessWidget {
  // TODO deleteFunction, modifyFunction, voteFunction 등을 따로 받아서 완전히 독립적으로 동작할 수 있게하면 좋을것 같다.
  const CommentCard({
    super.key,
    required this.communityName,
    required this.postId,
    required this.userName,
    required this.createdAt,
    required this.commentId,
    required this.comment,
    this.deleteFunction,
    this.modifyFunction,
    this.voteFunction,
  });

  final String communityName;
  final int postId;
  final String userName;
  final int createdAt;
  final int commentId;
  final String comment;
  final Function()? deleteFunction;
  final Function()? modifyFunction;
  final Function()? voteFunction;

  final int voteCount = 0;

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
                onTap: () => context
                    .read<CommentPageProvider>()
                    .navigateToUser(userName),
                child: Text(
                  userName,
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
              Utils.formatTimeStamp(createdAt),
              style:
                  TextStyle(color: Colors.black.withOpacity(0.5), fontSize: 14),
            ),
          )
        ],
      ),
    );
  }

  String formatVoteCount(int voteCount) {
    const trillion = 1000000000000;
    const billion = 1000000000;
    const million = 1000000;
    const kilo = 1000;

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

  void _checkCommentState(
      bool isDeleted, CommentPageState commentPageState, BuildContext context) {
    if (isDeleted) {
      // FIXME 만약 현재 페이지가 마지막이고 댓글을 지울경우 페이지가 사라지는 경우 예외처리 필요
      context
          .read<CommentPageProvider>()
          .getCommentPage(commentPageState.currentPageNum);
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("댓글 삭제 완료"));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("댓글 삭제 실패"));
    }
  }

  // FIXME 프로바이더 사용 문제 떄문에 CommentCard는 완전히 독립적이지 않다.
  // deleteFunction 등의 인자를 받아서 아래의 _deleteComment를 대체해야한다.
  void _deleteComment(AuthenticationState loginState,
      CommentPageState commentPageState, BuildContext context) {
    if (loginState is AuthorizedState) {
      context
          .read<CommentPageProvider>()
          .deleteComment(
            // communityName,
            postId,
            commentId,
            loginState.loginToken,
          )
          .then(
              (value) => _checkCommentState(value, commentPageState, context));
    } else {
      // Stateless에서는 인자를 주지 않으면 Undefined name 'context'가 발생한다.
      // Stateful에서는 인자를 안줘도 해당 오류가 발생하지 않는다.
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("로그인이 필요함"));
    }
  }

  Widget _bottom(AuthenticationState loginState,
      CommentPageState commentPageState, BuildContext context) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(
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
              child: SelectionArea(
                child: Text(
                  comment,
                  style: const TextStyle(color: Colors.black),
                ),
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
