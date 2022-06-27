import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/widgets/main_navigation_bar/main_navigation_bar.dart';
import 'package:cuteshrew/widgets/posting_panel/posting_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ButtonProperties {
  int page;
  Color color;
  bool selected;

  ButtonProperties(
      {required this.page, this.color = Colors.black, this.selected = false});
}

class CommunityPage extends StatefulWidget {
  static const pageName = '/community';
  final Map<String, dynamic> _arguments;

  const CommunityPage(this._arguments, {Key? key}) : super(key: key);

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

//FIXME 페이지를 바꿀 때마다 위젯을 새로 생성하는 행위는 매우 심각한 렉을 유발함 네트워크 응답이 동기라서 혹은 애니메이션 사용?
//FIXME https://stackoverflow.com/questions/49874272/how-to-navigate-to-other-page-without-animation-flutter 이거를 사용해야할 때
class _CommunityPageState extends State<CommunityPage> {
  HttpService httpService = HttpService();
  int _currentPageNum = 1;
  int _pagePerCount = 15;
  int _maxPage = 1;
  Community? _currentCommunity;
  List<ButtonProperties> _pageButtonList = [];

  @override
  void initState() {
    super.initState();
    Community communityInfo = widget._arguments['communityInfo'] as Community;
    _currentPageNum = widget._arguments['page'] != null
        ? widget._arguments['page'] as int
        : 1;

    httpService
        .getCommunity(
            communityInfo.communityName, _currentPageNum, _pagePerCount)
        .then((value) {
      setState(() {
        _currentCommunity = value;
        _maxPage = _currentCommunity!.postingsCount ~/ _pagePerCount + 1;

        // 1~10 11~20 21~30 ... max 1 ~ max
        int maxSelectablePage = (((_currentPageNum - 1) ~/ 10) + 1) * 10;
        int minSelectablePage = maxSelectablePage - 9;
        (maxSelectablePage > _maxPage) ? maxSelectablePage = _maxPage : null;

        _pageButtonList = List<ButtonProperties>.generate(
            maxSelectablePage - minSelectablePage + 1,
            (index) => ButtonProperties(page: minSelectablePage + index));
        // print(
        //     "posting count = ${_currentCommunity!.postingsCount} min = $minSelectablePage max = $maxSelectablePage");
        // for (var i in _pageButtonList) {
        //   print(i.page);
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 토큰을 build에 선언하지 않고 멤버 변수로 설정하면 변경사항을 잡지 못한다 Lifecycle과 관련이 있는듯
    LoginToken? token =
        context.select((LoginProvider login) => login.loginToken);

    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          const MainNavigationBar(),
          (_currentCommunity == null)
              ? const CircularProgressIndicator()
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                          style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              height: 0.9),
                          _currentCommunity!.communityShowName),
                    ),
                    PostingPanel(
                        community: _currentCommunity!,
                        posts: _currentCommunity!.latestPostingList),
                    //FIXME 이게 정말 최선인가? 진짜 보기 싫은 코드다
                    ConstrainedBox(
                      constraints: BoxConstraints(maxHeight: 100.0),
                      child: Center(
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.all(15),
                            itemCount: _pageButtonList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                width: 50,
                                height: 50,
                                child: ElevatedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                (_pageButtonList[index].page ==
                                                        _currentPageNum)
                                                    ? Colors.blue
                                                    : Colors.cyan)),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CommunityPage({
                                                  'communityInfo':
                                                      _currentCommunity,
                                                  'page': _pageButtonList[index]
                                                      .page
                                                })),
                                      );
                                    },
                                    child: Text(
                                        '${_pageButtonList[index].page}',
                                        style: TextStyle(color: Colors.white))),
                              );
                            }),
                      ),
                    )
                  ],
                )
        ],
      ),
      floatingActionButton: (token != null && _currentCommunity != null)
          ? FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          PostEditorPage({'communityInfo': _currentCommunity})),
                );
              },
              child: const Icon(Icons.note_add),
            )
          : null,
    );
  }
}
