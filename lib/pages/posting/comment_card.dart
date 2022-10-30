import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/models/comment_detail.dart';
import 'package:cuteshrew/utils/utils.dart';
import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  CommentCard({super.key, required this.comment});

  CommentDetail comment;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          color: Colors.grey[300],
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                    width: 5,
                  ),
                  Text(
                    comment.userInfo.name,
                    style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  )
                ],
              ),
              // 시간
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  Utils.formatTimeStamp(comment.createdAt),
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5), fontSize: 14),
                ),
              )
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            // 이렇게 하면 가로가 자동으로 부모에 맞게 꽉 채워진다 Expanded는 상위 위젯이 Listview라 사용 불가
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                comment.comment,
                style: const TextStyle(color: Colors.black),
              ),
              Container(),
            ],
          ),
        ),
      ],
    );
  }
}
