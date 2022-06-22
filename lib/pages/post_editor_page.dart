import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:provider/provider.dart';

// FIXME
//Assertion failed: file:///C:/flutter/packages/flutter/lib/src/services/hardware_keyboard.dart:444:16

class PostEditorPage extends StatelessWidget {
  static const pageName = '/write';
  final Map<String, Community> _arguments;

  PostEditorPage(this._arguments, {Key? key}) : super(key: key);

  final int _titleLengthLimit = 255;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.transparent, width: 0));

  final TextEditingController _titleController = TextEditingController();
  final HtmlEditorController _bodyController = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    HttpService httpService = HttpService();
    var token = context.select((LoginProvider login) => login.loginToken);
    Community communityInfo = _arguments['communityInfo'] as Community;
    return ChangeNotifierProvider(
      create: (BuildContext context) => LoginProvider(),
      child: Scaffold(
        body: ListView(
          children: [
            MainNavigationBar(),
            SizedBox(
              height: 16,
            ),
            _buildTextFormField("제목", _titleController),
            SizedBox(
              height: 8,
            ),
            HtmlEditor(
              controller: _bodyController, //required
              htmlEditorOptions: HtmlEditorOptions(
                hint: "내용 입력점",
              ),
              otherOptions: OtherOptions(
                height: 400,
              ),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var bodyHtml = await _bodyController.getText();
            if (token != null) {
              httpService
                  .uploadPosting(communityInfo.communityName, token,
                      PostCreate(title: _titleController.text, body: bodyHtml))
                  .then((value) => {
                        if (value) {Navigator.pop(context)}
                      });
            }
          },
          child: const Icon(Icons.note_add),
        ),
      ),
    );
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController controller) {
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
