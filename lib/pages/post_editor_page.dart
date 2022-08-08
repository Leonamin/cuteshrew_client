import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/post_detail.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';
import 'package:cuteshrew/services/navigation_service.dart';

// FIXME
//Assertion failed: file:///C:/flutter/packages/flutter/lib/src/services/hardware_keyboard.dart:444:16

// arguments
// communityInfo: Community 포스팅 업로드시 커뮤니티 구분에 사용
// postInfo: PostDetail[Optional] 포스팅 수정시 내용 가져오기
// isModity: bool[Optional] 포스팅 새로작성, 수정인지 구분
class PostEditorPage extends StatelessWidget {
  static const pageName = '/write';
  final Map<String, dynamic> _arguments;

  PostEditorPage(this._arguments, {Key? key}) : super(key: key);

  final int _titleLengthLimit = 255;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.transparent, width: 0));

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final HtmlEditorController _bodyController = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
    Community communityInfo = _arguments['communityInfo'] as Community;
    bool isModify = _arguments['isModify'] != null ? true : false;
    PostDetail postInfo = (isModify)
        ? _arguments['postDetail'] as PostDetail
        : PostDetail(postId: 0, title: "", body: "", isLocked: false);
    _titleController.text = postInfo.title;

    return Consumer<LoginState>(
      builder: (context, state, child) {
        return Scaffold(
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: RichText(
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        text: TextSpan(
                            style: const TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 30,
                                fontWeight: FontWeight.w800,
                                height: 0.9),
                            text: communityInfo.communityShowName,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                locator<NavigationService>()
                                    .pushNamed(CommunityPageRoute, arguments: {
                                  'communityInfo': communityInfo,
                                });
                              }),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    _buildTextFormField("제목", _titleController),
                    const SizedBox(
                      height: 8,
                    ),
                  ],
                ),
              ),
              Expanded(
                  flex: 8,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 8,
                        child: HtmlEditor(
                          controller: _bodyController, //required
                          htmlEditorOptions: HtmlEditorOptions(
                              hint: "내용 입력점", initialText: postInfo.body),
                          otherOptions: const OtherOptions(
                            height: 400,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            _buildTextFormField("비밀번호", _passwordController),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.cancel_presentation)),
                                IconButton(
                                    onPressed: () async {
                                      var bodyHtml =
                                          await _bodyController.getText();
                                      if (state is AuthorizedState) {
                                        PostCreate post = PostCreate(
                                            title: _titleController.text,
                                            body: bodyHtml,
                                            isLocked: _passwordController
                                                .text.isNotEmpty,
                                            password: _passwordController.text);
                                        if (!isModify) {
                                          httpService
                                              .uploadPosting(
                                                  communityInfo.communityName,
                                                  state.loginToken,
                                                  post)
                                              .then((value) => {
                                                    if (value)
                                                      {
                                                        locator<NavigationService>()
                                                            .pop()
                                                      }
                                                  });
                                        } else {
                                          httpService
                                              .updatePosting(
                                                  communityInfo.communityName,
                                                  state.loginToken,
                                                  postInfo.postId,
                                                  post)
                                              .then((value) => {
                                                    if (value)
                                                      {
                                                        locator<NavigationService>()
                                                            .pushNamed(
                                                                PostingPageRoute,
                                                                arguments: {
                                                              'communityInfo':
                                                                  communityInfo,
                                                              'postId': postInfo
                                                                  .postId
                                                            })
                                                      }
                                                  });
                                        }
                                      }
                                    },
                                    icon: const Icon(Icons.note_add_outlined)),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
            ],
          ),
        );
      },
    );
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController controller,
      {String title = ""}) {
    return TextFormField(
      inputFormatters: [LengthLimitingTextInputFormatter(_titleLengthLimit)],
      cursorColor: Colors.white,
      controller: controller,
      validator: (text) {
        if (text == null || text.isEmpty) {
          return "이거 비어있으면 안됨";
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: labelText,
          border: _border,
          errorBorder: _border,
          enabledBorder: _border,
          focusedBorder: _border,
          filled: true,
          fillColor: Colors.black54,
          errorStyle: const TextStyle(
              color: Colors.redAccent, fontWeight: FontWeight.bold),
          labelStyle: const TextStyle(color: Colors.white)),
    );
  }
}
