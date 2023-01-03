import 'package:cuteshrew/core/data/datasource/remote/comment_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/user_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/comment_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/user_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/show_user_page_usecase.dart';
import 'package:cuteshrew/presentation/data/comment_detail_data.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/data/user_preview_data.dart';
import 'package:cuteshrew/presentation/screens/user/provders/user_page_provider.dart';
import 'package:cuteshrew/presentation/screens/user/widget/tab_bar_delegate.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  SnackBar _makeSnackBar(String content, [Color? backgroundColor]) {
    return SnackBar(
      content: Text(content),
      backgroundColor: backgroundColor,
    );
  }

  // 앱바가 펴진 상태에서 보여줄 위젯
  _userInfoWidget(UserPreviewData user) {
    return SafeArea(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 48),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            // child: Image.network(
            //   userImage,
            //   fit: BoxFit.cover,
            //   height: 100,
            //   width: 100,
            // ),
            child: Container(
              color: Colors.white,
              child: Icon(Icons.person_outline_outlined, size: 100),
            ),
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          user.name,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Text(user.email),
        const SizedBox(
          height: 8,
        ),
        Text(
          //user.profile.introduce
          "Introduce",
        ),
      ],
    ));
  }

  // 앱바가 줄여진 상태에서 보여줄 위젯
  _shrinkUserInfoWidget(UserPreviewData user) {
    return [
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 12),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    user.email,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              // child: Image.network(
              //   headerImage,
              //   fit: BoxFit.cover,
              //   height: 30,
              //   width: 30,
              // ),
            ),
          ],
        ),
      ),
    ];
  }

  _appBar(UserPreviewData user) {
    return SliverAppBar(
      elevation: 0,
      // backgroundColor: Colors.grey.shade300,
      backgroundColor: Colors.grey.withAlpha(scrollPostionToAlpha.toInt()),
      pinned: true,
      expandedHeight: appBarHeight,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax,
        title: _isShrink ? Text("Profile") : null,
        background: _userInfoWidget(user),
      ),
      actions: _isShrink ? _shrinkUserInfoWidget(user) : null,
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

  commentCountToString(int count) {
    if (count >= 100) {
      return "99+";
    } else {
      return count.toString();
    }
  }

  _postingItemRow(PostingPreviewData posting) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: InkWell(
              onTap: () => context.read<UserPageProvider>().navigateToPosting(
                  posting.ownCommunity?.communityName ?? "", posting.postId),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      posting.title,
                      style: const TextStyle(color: Colors.black, fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      DateFormat('yy.MM.dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              posting.publishedAt * 1000)),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8), fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )),
            TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                    minimumSize: const Size(60, 60),
                    backgroundColor: Colors.grey.withOpacity(0.2)),
                child: Text(
                  commentCountToString(posting.commentCount),
                  maxLines: 1,
                )),
          ],
        ),
      ),
    );
  }

  _commentItemRow(CommentDetailData comment) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
                child: InkWell(
              onTap: () => context.read<UserPageProvider>().navigateToPosting(
                  comment.parentPosting.ownCommunity?.communityName ?? "",
                  comment.postId),
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      comment.parentPosting.title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      comment.comment,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    // TODO 게시글 시간은 어떻게 표현하면 좋을까
                    // 댓글 시간
                    Text(
                      DateFormat('yy.MM.dd').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              comment.createdAt * 1000)),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.8), fontSize: 12),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }

  _makePostingListWidget(
    PageStorageKey<String> key,
    UserPageProvider provider,
  ) {
    // 로딩 중이면서 캐시가 없음
    if (provider.isLoadingPosting && provider.userPostings.isEmpty) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 로딩 아닌데 캐시가 없음
    if (!provider.isLoadingPosting && provider.userPostings.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text("데이따 없음"),
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            key: _postingRefreshIndicatorKey,
            displacement: 50,
            onRefresh: () =>
                provider.refreshPostings(userName: widget.userName),
            child: CustomScrollView(
              key: key,
              // controller: controller, 이거 넣으면 sliver 효과 없어서 중첩 스크롤이 안된다.
              slivers: [
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),

                // FIXME 비효율적인 방식 리스트 아래 두개를 합쳐야한다.
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text(
                        "${provider.getEntirePostingCount} 개의 게시물이 있습니다");
                  }, childCount: 1)),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: provider.userPostings.length + 1,
                    (context, index) {
                      if (index < provider.userPostings.length) {
                        return _postingItemRow(provider.userPostings[index]);
                      }
                      return InkWell(
                        onTap: () {
                          provider
                              .fetchPostings(
                                  userName: widget.userName,
                                  startAtId:
                                      provider.userPostings[index - 1].postId,
                                  loadCount: 10)
                              .then(
                            (value) {
                              if (!provider.hasMorePosting) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(_makeSnackBar("마지막 게시글"));
                              }
                            },
                          );
                        },
                        child: SizedBox(
                          height: 50,
                          child: Center(
                              child: provider.isLoadingPosting
                                  ? const CircularProgressIndicator()
                                  : const Text("더보기")),
                        ),
                      );
                    },
                  )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  _makeCommentListWidget(
    PageStorageKey<String> pageStorageKey,
    UserPageProvider provider,
  ) {
    // 로딩 중이면서 캐시가 없음
    if (provider.isLoadingComment && provider.userComments.isEmpty) {
      return const SizedBox(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // 로딩 아닌데 캐시가 없음
    if (!provider.isLoadingComment && provider.userComments.isEmpty) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: Text("데이따 없음"),
        ),
      );
    }

    return SafeArea(
      top: false,
      bottom: false,
      child: Builder(
        builder: (context) {
          return RefreshIndicator(
            key: _commentRefreshIndicatorKey,
            displacement: 50,
            onRefresh: () =>
                provider.refreshComments(userName: widget.userName),
            child: CustomScrollView(
              key: pageStorageKey,
              // controller: controller, 이거 넣으면 sliver 효과 없어서 중첩 스크롤이 안된다.
              slivers: [
                SliverOverlapInjector(
                  handle:
                      NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                ),

                // FIXME 비효율적인 방식 리스트 아래 두개를 합쳐야한다.
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                    return Text(
                        "${provider.getEntireCommentCount} 개의 댓글이 있습니다");
                  }, childCount: 1)),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                    childCount: provider.userComments.length + 1,
                    (context, index) {
                      if (index < provider.userComments.length) {
                        return _commentItemRow(provider.userComments[index]);
                      }
                      return InkWell(
                        onTap: () {
                          provider
                              .fetchComments(
                                  userName: widget.userName,
                                  startAtId: provider
                                      .userComments[index - 1].commentId)
                              .then((value) {
                            if (!provider.hasMoreComment) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(_makeSnackBar("마지막 댓글"));
                            }
                          });
                        },
                        child: SizedBox(
                          height: 50,
                          child: Center(
                              child: provider.isLoadingComment
                                  ? const CircularProgressIndicator()
                                  : const Text("더보기")),
                        ),
                      );
                    },
                  )),
                )
              ],
            ),
          );
        },
      ),
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
        provider.fetchPostings(userName: widget.userName);
        provider.fetchComments(userName: widget.userName);
        return provider;
      },
      child: Consumer<UserPageProvider>(
        builder: (context, provider, child) {
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
                        _appBar(UserPreviewData(
                            name: widget.userName, email: widget.userName)),
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
                        _makePostingListWidget(
                            PageStorageKey<String>("1"), provider),
                        _makeCommentListWidget(
                            PageStorageKey<String>("2"), provider),
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
