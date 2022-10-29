import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_detail.dart';
import 'package:cuteshrew/notifiers/comment_page_notifier.dart';
import 'package:cuteshrew/states/comment_page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  Community communityInfo;
  int postId;
  int? currentPageNum;

  CommentScreen({
    Key? key,
    required this.communityInfo,
    required this.postId,
    this.currentPageNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final notifier = CommentPageNotifier(
            postId: postId,
            communityInfo: communityInfo,
            currentPageNum: currentPageNum ?? 1,
            countPerPage: defaultCommentsCountPerPage,
            api: context.read<CuteshrewApiClient>());
        notifier.getCommentPage(currentPageNum ?? 1);
        return notifier;
      },
      child: ProxyProvider<CommentPageNotifier, CommentPageState>(
        update: (context, value, previous) => value.value,
        child: Consumer<CommentPageState>(builder: (context, state, child) {
          if (state is LoadedCommentPageState) {
            return LoadedCommentScreen(
              communityInfo: state.communityInfo,
              currentPageNum: state.currentPageNum,
              countPerPage: state.countPerPage,
              comments: state.comments,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
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

class LoadedCommentScreen extends StatefulWidget {
  Community communityInfo; // 현재 커뮤니티 정보
  int currentPageNum; // 현재 페이지 번호
  int countPerPage; // 한 페이지에 표시할 게시물 수
  List<CommentDetail> comments;

  LoadedCommentScreen({
    required this.communityInfo,
    required this.currentPageNum,
    required this.countPerPage,
    required this.comments,
    super.key,
  });

  @override
  State<LoadedCommentScreen> createState() => _LoadedCommentScreenState();
}

class _LoadedCommentScreenState extends State<LoadedCommentScreen> {
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

  Widget _makeCommentPanel(List<CommentDetail> comments) {
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return Container(
            child: Text(comments[index].comment),
          );
        }),
        separatorBuilder: (context, index) {
          return const Divider(
            thickness: 1,
          );
        },
        itemCount: comments.length);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _makeCommentPanel(widget.comments),
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
                            backgroundColor: MaterialStateProperty.all<Color>(
                                (_pageButtonList[index].page ==
                                        widget.currentPageNum)
                                    ? Colors.blue
                                    : Colors.cyan)),
                        onPressed: () {
                          //todo
                          context
                              .read<CommentPageNotifier>()
                              .getCommentPage(index);
                        },
                        child: Text('${_pageButtonList[index].page}',
                            style: const TextStyle(color: Colors.white))),
                  );
                }),
          ),
        )
      ],
    );
  }
}
