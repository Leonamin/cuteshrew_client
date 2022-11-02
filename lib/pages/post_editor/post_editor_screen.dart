import 'dart:html';

import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/pages/community/community_page.dart';
import 'package:cuteshrew/pages/posting/posting_page.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

// FIXME
//Assertion failed: file:///C:/flutter/packages/flutter/lib/src/services/hardware_keyboard.dart:444:16
// 포커스 문제 HTML 에디터 포커스가 활성화 된 상태에서 다른 텍스트폼 포커스가 씹힘

// arguments
// communityInfo: Community 포스팅 업로드시 커뮤니티 구분에 사용
// originPost: PostDetail[Optional] 포스팅 수정시 내용 가져오기
// isModify: bool[Optional] 포스팅 새로작성, 수정인지 구분
class PostEditorScreen extends StatefulWidget {
  static const pageName = '/write';
  Community communityInfo;
  PostDetail? originPost;
  bool isModify;

  PostEditorScreen({
    Key? key,
    required this.communityInfo,
    this.originPost,
    required this.isModify,
  }) : super(key: key);

  @override
  State<PostEditorScreen> createState() => _PostEditorScreenState();
}

class _PostEditorScreenState extends State<PostEditorScreen> {
  final int _titleLengthLimit = 255;

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.black, width: 1));

  final TextEditingController _communitySeletController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final HtmlEditorController _editorController = HtmlEditorController();

  Widget _makeHeader() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "글쓰기",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  OutlinedButton(
                      onPressed: () {},
                      child: Text("임시저장",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.black.withOpacity(0.8)))),
                  const SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[100]),
                      child: Text(
                        "등록",
                        style:
                            TextStyle(fontSize: 14, color: Colors.green[500]),
                      ))
                ],
              )
            ],
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(
    TextEditingController controller, [
    String? labelText,
    String? hintText,
    bool enable = true,
  ]) {
    return GestureDetector(
      onTap: () {
        _editorController.clearFocus();
      },
      child: TextFormField(
        enabled: enable,
        inputFormatters: [LengthLimitingTextInputFormatter(_titleLengthLimit)],
        cursorColor: Colors.black,
        controller: controller,
        validator: (text) {
          if (text == null || text.isEmpty) {
            return "이거 비어있으면 안됨";
          }

          return null;
        },
        decoration: InputDecoration(
            labelText: labelText,
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.black),
            labelStyle: const TextStyle(color: Colors.black),
            border: _border,
            errorBorder: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            filled: true,
            fillColor: Colors.transparent,
            errorStyle: const TextStyle(
                color: Colors.redAccent, fontWeight: FontWeight.bold),
            floatingLabelBehavior: FloatingLabelBehavior.never),
      ),
    );
  }

  Widget _makeBody() {
    return Column(
      children: [
        _buildTextFormField(
          _communitySeletController,
          "게시판",
          "게시판",
          false,
        ),
        const SizedBox(
          height: 8,
        ),
        _buildTextFormField(_titleController, "제목", "제목"),
        const SizedBox(
          height: 8,
        ),
        Expanded(
            child: HtmlEditor(
          controller: _editorController,
          htmlEditorOptions:
              HtmlEditorOptions(initialText: widget.originPost?.body),
        )),
        const SizedBox(
          height: 8,
        ),
        _buildTextFormField(_passwordController, "비밀번호", "비밀번호"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    _communitySeletController.text = widget.communityInfo.communityShowName;
    _titleController.text = widget.originPost?.title ?? "";

    return Consumer<LoginState>(
      builder: (context, state, child) {
        return Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Column(
              children: [
                _makeHeader(),
                Expanded(child: _makeBody()),

                // Expanded(
                //     flex: 8,
                //     child: Column(
                //       children: [
                //         Expanded(
                //           flex: 8,
                //           child: HtmlEditor(
                //             controller: _bodyController, //required
                //             htmlEditorOptions: HtmlEditorOptions(
                //                 hint: "내용 입력점", initialText: originPost?.body),
                //             otherOptions: const OtherOptions(
                //               height: 400,
                //             ),
                //           ),
                //         ),
                //         const SizedBox(
                //           height: 10,
                //         ),
                //         Expanded(
                //           flex: 2,
                //           child: Column(
                //             children: [
                //               _buildTextFormField("비밀번호", _passwordController),
                //               Row(
                //                 mainAxisAlignment: MainAxisAlignment.end,
                //                 children: [
                //                   IconButton(
                //                       onPressed: () {},
                //                       icon:
                //                           const Icon(Icons.cancel_presentation)),
                //                   IconButton(
                //                       onPressed: () async {
                //                         var bodyHtml =
                //                             await _bodyController.getText();
                //                         if (state is AuthorizedState) {
                //                           PostCreate post = PostCreate(
                //                               title: _titleController.text,
                //                               body: bodyHtml,
                //                               isLocked: _passwordController
                //                                   .text.isNotEmpty,
                //                               password: _passwordController.text);
                //                           if (!isModify) {
                //                             httpService
                //                                 .uploadPosting(
                //                                     communityInfo.communityName,
                //                                     state.loginToken,
                //                                     post)
                //                                 .then((value) => {
                //                                       if (value)
                //                                         {Navigator.pop(context)}
                //                                     });
                //                           } else {
                //                             httpService
                //                                 .updatePosting(
                //                                     communityInfo.communityName,
                //                                     state.loginToken,
                //                                     originPost?.postId ?? 0,
                //                                     post)
                //                                 .then((value) => {
                //                                       if (value)
                //                                         {
                //                                           Navigator.push(
                //                                               context,
                //                                               MaterialPageRoute(
                //                                                   builder:
                //                                                       (context) =>
                //                                                           PostingPage(
                //                                                             communityInfo:
                //                                                                 communityInfo,
                //                                                             postId:
                //                                                                 originPost!.postId,
                //                                                           )))
                //                                         }
                //                                     });
                //                           }
                //                         }
                //                       },
                //                       icon: const Icon(Icons.note_add_outlined)),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         )
                //       ],
                //     )),
              ],
            ),
          ),
        );
      },
    );
  }
}
