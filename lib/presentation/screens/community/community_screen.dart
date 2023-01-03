import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/core/data/datasource/remote/community_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/community_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/show_community_page_usecase.dart';
import 'package:cuteshrew/presentation/config/route/url_query_parameters.dart';
import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/screens/community/providers/community_page_provider.dart';
import 'package:cuteshrew/presentation/screens/community/providers/community_page_state.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/list_button.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/posting_preview_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
communityInfo: 현재 페이지 정보
currentPageNum: 받아올 페이지 번호 없으면 기본 1번 시작(추후 uri를 통해 미리 구현)
*/
class CommunityScreen extends StatelessWidget {
  const CommunityScreen({
    Key? key,
    required this.communityName,
    this.currentPageNum,
  }) : super(key: key);

  final String communityName;
  final int? currentPageNum;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final notifier = CommunityPageProvider(
            communityPageUseCase: ShowCommunityPageUseCase(
                communityRepository: CommunityRepositoryImpl(
                  communityRemoteDataSource: CommunityRemoteDataSource(),
                ),
                postingRepository: PostingRepositoryImpl(
                  postingRemoteDataSource: PostingRemoteDataSource(),
                )),
            communityName: communityName,
            currentPageNum: currentPageNum ?? 1,
            countPerPage: defaultCountPerPage);
        notifier.getCommunityInfo(currentPageNum ?? 1);
        return notifier;
      },
      child: ProxyProvider<CommunityPageProvider, CommunityPageState>(
        update: (context, value, previous) => value.value,
        child: Consumer<CommunityPageState>(builder: (context, value, child) {
          return Scaffold(
            body: () {
              if (value is LoadedDataCommunityPageState) {
                return LoadedDataCommunityScreen(
                  communityName: value.communityName,
                  communityShowName: value.communityShowName,
                  postingCount: value.communityPostingCount,
                  postings: value.currentPagePostings,
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

class LoadedDataCommunityScreen extends StatefulWidget {
  final String communityName; // 현재 커뮤니티 정보
  final String communityShowName;
  final int postingCount;
  final List<PostingData> postings;

  final int currentPageNum; // 현재 페이지 번호
  final int countPerPage; // 한 페이지에 표시할 게시물 수

  const LoadedDataCommunityScreen({
    required this.communityName,
    required this.communityShowName,
    required this.postingCount,
    required this.postings,
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
  List<ListButtonProperties> _pageButtonProperties = [];

  @override
  void initState() {
    super.initState();
    _maxPage = widget.postingCount ~/ widget.countPerPage + 1;
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
                  .read<CommunityPageProvider>()
                  .getCommunityInfo(_pageButtonProperties[index].id);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(builder: (context, state, child) {
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
                      widget.communityShowName),
                ),
                PostingPreviewPanel(
                    communityName: widget.communityName,
                    posts: widget.postings),
                ListButton(
                  itemCount: _pageButtonProperties.length,
                  propertyList: _pageButtonProperties,
                  selectedIndex: _pageButtonProperties[0].id,
                ),
              ],
            )
          ],
        ),
        floatingActionButton: state is AuthorizedState
            ? FloatingActionButton(
                onPressed: () {
                  locator<NavigationService>()
                      .navigateTo(Routes.PostEditorPageRoute, queryParams: {
                    UrlQueryParameters.communityName: widget.communityName
                  });
                },
                child: const Icon(Icons.note_add),
              )
            : null,
      );
    });
  }
}
