import 'dart:html';

import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/providers/posting_editor_provider.dart';
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

  SnackBar _makeSnackBar(String content, [Color? backgroundColor]) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
    );
  }

  void _check(PostingEdiorState state) {
    if (state == PostingEdiorState.COMPLETED) {
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(_makeSnackBar("포스팅 업로드 실패"));
    }
  }

  Widget _makeHeader(LoginState loginState) {
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
              Consumer<PostingEditorProvider>(
                builder: (context, value, child) {
                  return Row(
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
                          onPressed: () {
                            //TODO Event 체크 하는 함수를 만들어서 onPressd() 내부를 좀 줄이자
                            if (loginState is AuthorizedState) {
                              if (_titleController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_makeSnackBar("제목이 비어있습니다."));
                                return;
                              }
                              _editorController.getText().then((value) {
                                final bodyHtml = value;
                                if (bodyHtml.isEmpty) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      _makeSnackBar("내용이 비어있습니다."));
                                  return;
                                }
                                PostCreate newPosting = PostCreate(
                                    title: _titleController.text,
                                    body: bodyHtml,
                                    isLocked:
                                        _passwordController.text.isNotEmpty,
                                    password: _passwordController.text);
                                widget.isModify
                                    ? context
                                        .read<PostingEditorProvider>()
                                        .updatePosting(
                                            widget.communityInfo.communityName,
                                            loginState.loginToken,
                                            newPosting,
                                            widget.originPost!.postId)
                                        .then((state) => _check(state))
                                    : context
                                        .read<PostingEditorProvider>()
                                        .uploadPosting(
                                          widget.communityInfo.communityName,
                                          loginState.loginToken,
                                          newPosting,
                                        )
                                        .then((state) => _check(state));
                              });
                            } else {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_makeSnackBar("로그인이 필요합니다."));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[100]),
                          child: Text(
                            "등록",
                            style: TextStyle(
                                fontSize: 14, color: Colors.green[500]),
                          ))
                    ],
                  );
                },
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
        Consumer<PostingEditorProvider>(
          builder: (context, provider, child) {
            _communitySeletController.text =
                provider.selectedCommunity?.communityShowName ?? "";
            return _buildTextFormField(
              _communitySeletController,
              "게시판",
              "게시판",
              false,
            );
          },
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
      builder: (context, loginState, child) {
        return ChangeNotifierProvider(
            create: (context) {
              final provider = PostingEditorProvider(
                  api: context.read<CuteshrewApiClient>());
              provider.fetchCommunities().then((value) {
                provider.selectCommuinty(widget.communityInfo.communityName);
              });
              return provider;
            },
            child: Scaffold(
                body: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 8.0),
                    child: Column(
                      children: [
                        _makeHeader(loginState),
                        Expanded(child: _makeBody())
                      ],
                    ))));
      },
    );
  }
}
