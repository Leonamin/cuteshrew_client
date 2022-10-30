import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/models/comment_detail.dart';
import 'package:cuteshrew/notifiers/comment_page_notifier.dart';
import 'package:cuteshrew/pages/posting/comment_card.dart';
import 'package:cuteshrew/states/comment_page_state.dart';
import 'package:cuteshrew/widgets/list_button.dart';
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
  List<ListButtonProperties> _pageButtonProperties = [];

  @override
  void initState() {
    super.initState();

    // 현재 페이지 기준으로 전 후 버튼 개수 만들기 알고리즘
    _maxPage = widget.comments.length ~/ widget.countPerPage + 1;
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
    _pageButtonProperties = List<ListButtonProperties>.generate(
        maxSelectablePage - minSelectablePage + 1,
        (index) => ListButtonProperties(
            id: minSelectablePage + index,
            color: Colors.blue,
            onPressed: () {
              context
                  .read<CommentPageNotifier>()
                  .getCommentPage(_pageButtonProperties[index].id);
            }));
  }

  Widget _makeCommentPanel(List<CommentDetail> comments) {
    if (comments.isEmpty) {
      // 이렇게 하면 width를 부모의 크기만큼 사용한다. Expanded를 쓰면 ListView라서 에러발생
      return Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              height: 40,
            ),
            const Text("댓글이 아직 없습니다."),
            Container(),
          ],
        ),
      );
    }
    return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: ((context, index) {
          return CommentCard(comment: comments[index]);
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
        ListButton(
          itemCount: _pageButtonProperties.length,
          propertyList: _pageButtonProperties,
          selectedIndex: _pageButtonProperties[0].id,
        ),
        //CommentEditor()
      ],
    );
  }
}
