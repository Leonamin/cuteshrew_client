import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:file_picker/file_picker.dart';

class WritingPage extends StatefulWidget {
  const WritingPage({Key? key}) : super(key: key);

  @override
  State<WritingPage> createState() => _WritingPageState();
}

class _WritingPageState extends State<WritingPage> {
  final int imageSizeLimit = 2097152;   // 2MB
  final int imageCountLimit = 20;       // up to 20 picture
  String result = '';
  final HtmlEditorController controller = HtmlEditorController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!kIsWeb) {
          controller.clearFocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("작성"),
          elevation: 0,
          actions: [
            IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  if (kIsWeb) {
                    controller.reloadWeb();
                  } else {
                    controller.editorController!.reload();
                  }
                })
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            var txt = await controller.getText();
            if (txt.contains('src=\"data:')) {
              txt =
              '<text removed due to base-64 data, displaying the text could cause the app to crash>';
            }
            setState(() {
              result = txt;
              print(result);
            });
          },
          label: const Text(r'submit',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(margin: EdgeInsets.all(10),
                  padding: EdgeInsets.all(5),decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 5,
                    )), child:
              HtmlEditor(
                controller: controller, //required
                htmlEditorOptions: HtmlEditorOptions(
                  hint: "여기에 입력하세요",
                ),
                otherOptions: OtherOptions(
                  height: 800,
                ),
              ),)
            ],
          ),
        ),
      ),
    );
  }
}
