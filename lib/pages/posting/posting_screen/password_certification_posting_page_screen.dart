import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/providers/posting_page_notifier.dart';
import 'package:cuteshrew/providers/posting_password_provider.dart';
import 'package:cuteshrew/states/posting_page_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class PasswordCertificationPostingPageScreen extends StatelessWidget {
  PasswordCertificationPostingPageScreen({
    Key? key,
    required this.postingPageState,
  }) : super(key: key);

  final PostingPageState postingPageState;

  static const int _passwordLengthLimit = 20;
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.transparent, width: 0));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  SnackBar _makeSnackBar(String content,
      [Color? textColor, Color? backgroundColor]) {
    return SnackBar(
      content: Text(
        content,
        style: TextStyle(color: textColor),
      ),
      backgroundColor: backgroundColor,
    );
  }

  void _checkState(BuildContext context, PostingPasswordState state) {
    if (state == PostingPasswordState.VALID) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      context.read<PostingNotifier>().setPosting(
          postingPageState.communityInfo,
          postingPageState.postId,
          context.read<PostingPasswordProvider>().posting!);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(_makeSnackBar("비밀번호 틀림", Colors.white, Colors.red));
    }
  }

  void _getPosting(BuildContext context, String password) {
    context
        .read<PostingPasswordProvider>()
        .getPosting(password)
        .then((value) => _checkState(context, value));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PostingPasswordProvider(
          api: context.read<CuteshrewApiClient>(),
          communityInfo: postingPageState.communityInfo,
          postId: postingPageState.postId),
      builder: (context, child) => Column(
        children: [
          const Text("잠긴 게시물입니다!"),
          TextFormField(
            inputFormatters: [
              LengthLimitingTextInputFormatter(_passwordLengthLimit)
            ],
            textInputAction: TextInputAction.go,
            onFieldSubmitted: (value) {
              _getPosting(context, value);
            },
            cursorColor: Colors.white,
            controller: _passwordController,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return "이거 비어있으면 안됨";
              }

              return null;
            },
            decoration: InputDecoration(
                labelText: "비밀번호",
                border: _border,
                errorBorder: _border,
                enabledBorder: _border,
                focusedBorder: _border,
                filled: true,
                fillColor: Colors.black54,
                errorStyle: const TextStyle(
                    color: Colors.redAccent, fontWeight: FontWeight.bold),
                labelStyle: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
