import 'package:cuteshrew/core/data/datasource/remote/comment_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/user_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/comment_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/user_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/show_user_page_usecase.dart';
import 'package:cuteshrew/presentation/screens/user/provders/user_page_provider.dart';
import 'package:cuteshrew/presentation/screens/user/widget/large_user_info.dart';
import 'package:cuteshrew/presentation/screens/user/widget/small_user_info.dart';
import 'package:cuteshrew/presentation/screens/user/widget/tab_bar_delegate.dart';
import 'package:cuteshrew/presentation/screens/user/widget/user_comment_info_list.dart';
import 'package:cuteshrew/presentation/screens/user/widget/user_posting_info_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SmallUserScreen extends StatefulWidget {
  final String userName;
  const SmallUserScreen({super.key, required this.userName});

  @override
  State<SmallUserScreen> createState() => _SmallUserScreenState();
}

class _SmallUserScreenState extends State<SmallUserScreen> {
  @override
  Widget build(BuildContext context) {
    return LoadedSmallUserScreen(
      userName: widget.userName,
    );
  }
}

class NotFoundSmallUserScreen extends StatelessWidget {
  const NotFoundSmallUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text("해당 사용자는 존재하지 않습니다."),
          const SizedBox(
            height: 8,
          ),
          TextButton(
              onPressed: () =>
                  context.read<UserPageProvider>().navigateToHome(),
              child: const Text("홈으로")),
        ],
      ),
    );
  }
}

class LoadedSmallUserScreen extends StatefulWidget {
  final String userName;
  const LoadedSmallUserScreen({super.key, required this.userName});

  @override
  State<LoadedSmallUserScreen> createState() => _LoadedSmallUserScreenState();
}

class _LoadedSmallUserScreenState extends State<LoadedSmallUserScreen>
    with TickerProviderStateMixin {
  ScrollController? _mainScrollController;
  TabController? _tabController;
  final GlobalKey<RefreshIndicatorState> _postingRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<RefreshIndicatorState> _commentRefreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  bool lastStatus = true; // 이거 사실 안씀
  double appBarHeight = 275;

  double scrollPostionToAlpha = 0;
  AnimationController? _animationController;

  // 앱바가 숨겨지려면 역방향으로 내려야해서 Offset이 늘어난다
  bool get _isShrink {
    return _mainScrollController != null &&
        _mainScrollController!.hasClients &&
        _mainScrollController!.offset > (appBarHeight - kToolbarHeight);
  }

  void _mainScrollListener() {
    if (_isShrink != lastStatus) {
      setState(() {
        lastStatus = _isShrink;
      });
    }

    setState(() {
      // 펼쳐지면 색 안보이고 닫혀지면 색 보이게
      if (_mainScrollController!.offset > (appBarHeight - kToolbarHeight)) {
        scrollPostionToAlpha = 255;
      } else {
        scrollPostionToAlpha = _mainScrollController!.offset *
            (100 / (appBarHeight - kToolbarHeight));
      }
      _animationController!.value = scrollPostionToAlpha / 255;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _mainScrollController = ScrollController()
      ..addListener(_mainScrollListener);
    _tabController = TabController(initialIndex: 0, length: 2, vsync: this);

    //기능 앱바 스크롤 색상전환 애니메이션 등록
    _animationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _mainScrollController?.removeListener(_mainScrollListener);
    _mainScrollController?.dispose();
    super.dispose();
  }

  _appBar(UserPageProvider provider) {
    return SliverAppBar(
      elevation: 0,
      // backgroundColor: Colors.grey.shade300,
      backgroundColor: Colors.grey.withAlpha(scrollPostionToAlpha.toInt()),
      pinned: true,
      expandedHeight: appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: _isShrink ? Text("Profile") : null,
        background: LargeUserInfo(
          userName: provider.userName,
          userEmail: provider.userEmail,
          introduction: provider.userIntroduction,
        ),
      ),
      actions: _isShrink
          ? [
              SmallUserInfo(
                userName: provider.userName,
                userEmail: provider.userEmail,
              )
            ]
          : null,
    );
  }

  _tabBar() {
    return SliverPersistentHeader(
      delegate: TabBarDelegate(tabcontroller: _tabController!, tabs: [
        Tab(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: const Text("게시글"),
          ),
        ),
        Tab(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            color: Colors.white,
            child: const Text("댓글"),
          ),
        ),
      ]),
      pinned: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final provider = UserPageProvider(
          userPageUsecase: ShowUserPageUsecase(
              userRepository: UserRepositoryImpl(
                userRemoteDataSource: UserRemoteDataSource(),
              ),
              postingRepository: PostingRepositoryImpl(
                postingRemoteDataSource: PostingRemoteDataSource(),
              ),
              commentRepository: CommentRepositoryImpl(
                commentRemoteDatasource: CommentRemoteDataSource(),
              )),
        );
        provider(userName: widget.userName);
        provider.fetchPostings(userName: widget.userName);
        provider.fetchComments(userName: widget.userName);
        return provider;
      },
      child: Consumer<UserPageProvider>(
        builder: (context, provider, child) {
          // 이거 해보니 알게된 사실 스크롤 할 때마다 상태가 변하고 있었다.
          // print(provider.state);
          switch (provider.state) {
            case UserPageState.INIT:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case UserPageState.USER_FOUND:
              return Scaffold(
                body: NestedScrollView(
                    controller: _mainScrollController,
                    headerSliverBuilder: (context, innerBoxIsScrolled) {
                      return [
                        _appBar(provider),
                        SliverOverlapAbsorber(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                          sliver: _tabBar(),
                        ),
                      ];
                    },
                    body: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _tabController,
                      children: [
                        UserPostingInfoList(
                            pageStorageKey: PageStorageKey<String>("1"),
                            refreshIndicatorKey: _postingRefreshIndicatorKey),
                        UserCommentInfoList(
                            pageStorageKey: PageStorageKey<String>("2"),
                            refreshIndicatorKey: _commentRefreshIndicatorKey),
                      ],
                    )),
              );
            case UserPageState.USER_NOT_FOUND:
              return const NotFoundSmallUserScreen();
          }
        },
      ),
    );
  }
}
