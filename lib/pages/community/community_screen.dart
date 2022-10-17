import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/notifiers/community_page_notifier.dart';
import 'package:cuteshrew/pages/post_editor/post_editor_page.dart';
import 'package:cuteshrew/states/community_page_state.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/posting_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
communityInfo: 현재 페이지 정보
currentPageNum: 받아올 페이지 번호 없으면 기본 1번 시작(추후 uri를 통해 미리 구현)
*/
class CommunityScreen extends StatelessWidget {
  CommunityScreen({
    Key? key,
    required this.communityInfo,
    this.currentPageNum,
  }) : super(key: key);

  Community communityInfo;
  int? currentPageNum;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final notifier = CommunityPageNotifier(
            api: context.read<CuteshrewApiClient>(),
            communityInfo: communityInfo,
            currentPageNum: currentPageNum ?? 1,
            countPerPage: defaultCountPerPage);
        notifier.getCommunityInfo(currentPageNum ?? 1);
        return notifier;
      },
      child: ProxyProvider<CommunityPageNotifier, CommunityPageState>(
        update: (context, value, previous) => value.value,
        child: Consumer<CommunityPageState>(builder: (context, value, child) {
          return Scaffold(
            body: () {
              if (value is LoadedDataCommunityPageState) {
                return LoadedDataCommunityScreen(
                  communityInfo: value.communityInfo,
                  currentPageNum: value.currentPageNum,
                  countPerPage: value.countPerPage,
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }(),
          );
        }),
      ),
    );
  }
}

class ButtonProperties {
  int page;
  Color color;
  bool selected;

  ButtonProperties(
      {required this.page, this.color = Colors.black, this.selected = false});
}

class LoadedDataCommunityScreen extends StatefulWidget {
  Community communityInfo; // 현재 커뮤니티 정보
  int currentPageNum; // 현재 페이지 번호
  int countPerPage; // 한 페이지에 표시할 게시물 수

  LoadedDataCommunityScreen({
    required this.communityInfo,
    required this.currentPageNum,
    required this.countPerPage,
    super.key,
  });

  @override
  State<LoadedDataCommunityScreen> createState() =>
      _LoadedDataCommunityScreenState();
}

class _LoadedDataCommunityScreenState extends State<LoadedDataCommunityScreen> {
  // 현재 커뮤니티의 최대 페이지 모든페이지 / 표시할 게시물 수
  int _maxPage = 0;
  // 현재 페이지 번호로부터 전~후 최대 버튼 표시 범위 설정
  final int _pageRange = 4;
  // 페이지 번호 버튼 리스트
  List<ButtonProperties> _pageButtonList = [];

  @override
  void initState() {
    super.initState();
    _maxPage = widget.communityInfo.postingsCount ~/ widget.countPerPage + 1;
    int minSelectablePage = widget.currentPageNum - _pageRange;
    int maxSelectablePage = widget.currentPageNum + _pageRange;

    if (widget.currentPageNum - _pageRange <= 0) {
      minSelectablePage = 1;
      maxSelectablePage = 1 + (2 * _pageRange);
    }
    if (widget.currentPageNum + _pageRange > _maxPage) {
      minSelectablePage = _maxPage - (2 * _pageRange);
      maxSelectablePage = _maxPage;
    }
    if (widget.currentPageNum - _pageRange <= 0 &&
        widget.currentPageNum + _pageRange > _maxPage) {
      minSelectablePage = 1;
      maxSelectablePage = _maxPage;
    }
    _pageButtonList = List<ButtonProperties>.generate(
        maxSelectablePage - minSelectablePage + 1,
        (index) => ButtonProperties(page: minSelectablePage + index));
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
            Column(
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
                      widget.communityInfo.communityShowName),
                ),
                PostingPanel(
                    community: widget.communityInfo,
                    posts: widget.communityInfo.latestPostingList),
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
                                                    widget.currentPageNum)
                                                ? Colors.blue
                                                : Colors.cyan)),
                                onPressed: () {
                                  //todo
                                },
                                child: Text('${_pageButtonList[index].page}',
                                    style: TextStyle(color: Colors.white))),
                          );
                        }),
                  ),
                )
              ],
            )
          ],
        ),
        floatingActionButton: state is AuthorizedState
            ? FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PostEditorPage(
                                communityInfo: widget.communityInfo,
                                isModify: false,
                              )));
                },
                child: const Icon(Icons.note_add),
              )
            : null,
      );
    });
  }
}
