import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/screens/comment/widgets/comment_card.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/list_button.dart';
import 'package:flutter/material.dart';

class LoadedCommentScreen extends StatefulWidget {
  final String communityName; // 현재 커뮤니티 정보
  final int postId;
  final int currentPageNum; // 현재 페이지 번호
  final int countPerPage; // 한 페이지에 표시할 게시물 수
  final List<CommentDetailData> comments;
  final Function(int pageNum)? onPageButtonPressed;

  const LoadedCommentScreen({
    required this.communityName,
    required this.postId,
    required this.currentPageNum,
    required this.countPerPage,
    required this.comments,
    this.onPageButtonPressed,
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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

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
        // onPressed: () {
        // context
        //     .read<CommentPageProvider>()
        //     .getCommentPage(_pageButtonProperties[index].id);
        // },
        // TODO 리스트 버튼 사용법이 좀 너무 복잡한거 같은데 나중에 손봐야함
        onPressed: () {
          widget.onPageButtonPressed != null
              ? widget.onPageButtonPressed!(_pageButtonProperties[index].id)
              : null;
        },
      ),
    );
  }

  Widget _makeCommentPanel(List<CommentDetailData> comments) {
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
          return CommentCard(
            communityName: widget.communityName,
            postId: widget.postId,
            comment: comments[index].comment,
            commentId: comments[index].commentId,
            createdAt: comments[index].createdAt,
            userName: comments[index].writer.name,
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
        // CommentEditor(
        //   communityInfo: widget.communityName,
        //   postId: widget.postId,
        // ),
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
