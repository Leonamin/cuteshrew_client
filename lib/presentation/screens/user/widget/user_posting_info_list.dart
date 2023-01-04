import 'package:cuteshrew/presentation/screens/user/provders/user_page_provider.dart';
import 'package:cuteshrew/presentation/screens/user/widget/user_posting_info_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPostingInfoList extends StatelessWidget {
  final PageStorageKey pageStorageKey;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;

  const UserPostingInfoList({
    super.key,
    required this.pageStorageKey,
    required this.refreshIndicatorKey,
  });

  String commentCountToString(int count) {
    if (count >= 100) {
      return "99+";
    } else {
      return count.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPageProvider>(
      builder: (context, provider, child) {
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
                key: refreshIndicatorKey,
                displacement: 50,
                onRefresh: () =>
                    provider.refreshPostings(userName: provider.userName),
                child: CustomScrollView(
                  key: pageStorageKey,
                  // controller: controller, 이거 넣으면 sliver 효과 없어서 중첩 스크롤이 안된다.
                  slivers: [
                    SliverOverlapInjector(
                      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                          context),
                    ),

                    // FIXME 비효율적인 방식 리스트 아래 두개를 합쳐야한다.
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      sliver: SliverList(
                          delegate:
                              SliverChildBuilderDelegate((context, index) {
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
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: UserPostingInfoItem(
                                title: provider.postingTitle(index),
                                datetime: provider.postingDateTime(index),
                                commentCount: commentCountToString(
                                  provider.userPostings[index].commentCount,
                                ),
                                onItemPressed: () => provider.navigateToPosting(
                                  provider.postingCommunityName(index),
                                  provider.postingId(index),
                                ),
                                onItemLongPressed: () {
                                  debugPrint("Long Press!");
                                },
                                onCommentItemPressed: () =>
                                    provider.navigateToPosting(
                                  provider.postingCommunityName(index),
                                  provider.postingId(index),
                                ),
                              ),
                            );
                          }
                          return InkWell(
                            onTap: () {
                              provider
                                  .fetchPostings(
                                      userName: provider.userName,
                                      // 그냥 index를 쓰면 더보기의 index를 사용한게 되므로
                                      startAtId: provider.lastPostingId,
                                      loadCount: 10)
                                  .then(
                                (value) {
                                  if (!provider.hasMorePosting) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      //FIXME 하드코딩 문자
                                      const SnackBar(
                                        content: Text("마지막 게시글"),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: provider.isLoadingPosting
                                    ? const CircularProgressIndicator()
                                    : const Text("더보기"),
                              ),
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
      },
    );
  }
}
