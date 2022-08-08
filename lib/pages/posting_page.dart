import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/strings/strings.dart';
import 'package:cuteshrew/widgets/clickable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:cuteshrew/services/navigation_service.dart';

class PostingPage extends StatefulWidget {
  static const pageName = '/post';

  final Map<String, dynamic> _arguments;

  const PostingPage(this._arguments, {Key? key}) : super(key: key);

  @override
  State<PostingPage> createState() => _PostingPageState();
}

class _PostingPageState extends State<PostingPage> {
  HttpService httpService = HttpService();
  late Community _communityInfo;
  late PostDetail _postDetail;
  late int _postId;

  Map<String, dynamic>? _postingResult;

  static const int _passwordLengthLimit = 20;
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: const BorderSide(color: Colors.transparent, width: 0));
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _communityInfo = widget._arguments['communityInfo'] as Community;
    _postId = widget._arguments['postId'] as int;
    httpService.getPosting(_communityInfo.communityName, _postId).then((value) {
      setState(() {
        _postingResult = value as Map<String, dynamic>?;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, state, child) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: ListView(
          children: [
            const SizedBox(
              height: 30.0,
            ),
            _buildBody(state),
          ],
        ),
      );
    });
  }

  //TODO PostingDetailNotifier 사용
  Widget _buildBody(state) {
    if (_postingResult != null) {
      switch (_postingResult?['code']) {
        case 200:
          return _buildPostingPanel(state, _postingResult?['data']);
        case 400:
        case 403:
          return _buildPasswordPanel();
        default:
      }
      return Container();
    }
    return const CircularProgressIndicator();
  }

  Widget _buildPostingPanel(state, PostDetail data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: state is AuthorizedState ? _buildToolTab(state, data) : null,
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          padding: const EdgeInsets.only(left: 10.0),
          child: ClickableText(
            text: _communityInfo.communityShowName,
            size: 30,
            weight: FontWeight.w800,
            onClick: () {
              locator<NavigationService>()
                  .pushNamed(CommunityPageRoute, arguments: {
                'communityInfo': _communityInfo,
              });
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Html(
          data: data.body,
        )
      ],
    );
  }

  Widget _buildPasswordPanel() {
    return Column(
      children: [
        Text("잠긴 게시물입니다!"),
        _buildTextFormField("비밀번호", _passwordController),
      ],
    );
  }

  Widget _buildToolTab(state, PostDetail postDetail) {
    return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
      OutlinedButton(
          onPressed: () {
            locator<NavigationService>().pushNamed(PostEditorPageRoute,
                arguments: {
                  'communityInfo': _communityInfo,
                  'postDetail': postDetail,
                  'isModify': true
                });
          },
          child: Row(
            children: const [
              Icon(Icons.edit),
              SizedBox(
                width: 5,
              ),
              Text("수정")
            ],
          )),
      ElevatedButton(
          onPressed: () {
            //TODO 임시로
            _showDialog(context, state);
          },
          //TODO 나중에 버튼 색상 좀...
          child: Row(
            children: const [
              Icon(Icons.delete_forever),
              SizedBox(
                width: 5,
              ),
              Text("삭제")
            ],
          ))
    ]);
  }

  //TODO 나중에 삭제점
  void _showDialog(BuildContext context, state) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: const Text(Strings.alretDeletePostingTitle),
          content: const Text(Strings.alretDeletePostingBody),
          actions: <Widget>[
            TextButton(
              child: const Text(Strings.alretAccept),
              onPressed: () {
                httpService
                    .deletePosting(_communityInfo.communityName,
                        state.loginToken.accessToken, _postId)
                    .then((value) => {
                          if (value)
                            {
                              Navigator.pop(context),
                              locator<NavigationService>().pushNamed(
                                  CommunityHomePageRoute,
                                  arguments: {'communityInfo': _communityInfo})
                            }
                          else
                            {
                              Navigator.pop(context),
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text(Strings.alarmDeletePostingFailed),
                              ))
                            }
                        });
              },
            ),
            TextButton(
              child: const Text(Strings.alretBack),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController controller,
      {String title = ""}) {
    return TextFormField(
      inputFormatters: [LengthLimitingTextInputFormatter(_passwordLengthLimit)],
      textInputAction: TextInputAction.go,
      onFieldSubmitted: (value) {
        httpService
            .getPosting(_communityInfo.communityName, _postId, value)
            .then((value) {
          if (value['code'] == 200) {
            setState(() {
              _postingResult = value;
            });
          }
        });
      },
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
