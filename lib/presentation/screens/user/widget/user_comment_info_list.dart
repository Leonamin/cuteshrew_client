import 'package:cuteshrew/presentation/screens/user/provders/user_page_provider.dart';
import 'package:cuteshrew/presentation/screens/user/widget/user_comment_info_item.dart';
import "package:flutter/material.dart";
import 'package:provider/provider.dart';

class UserCommentInfoList extends StatelessWidget {
  final PageStorageKey pageStorageKey;
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey;
  const UserCommentInfoList({
    super.key,
    required this.pageStorageKey,
    required this.refreshIndicatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPageProvider>(
      builder: (context, provider, child) {
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
                key: refreshIndicatorKey,
                displacement: 50,
                onRefresh: () =>
                    provider.refreshComments(userName: provider.userName),
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
                            return UserCommentInfoItem(
                              title: provider.commentPostingTitle(index),
                              comment: provider.commentAtIndex(index),
                              datetime: provider.commentDateTime(index),
                              onItemPressed: () => provider.navigateToPosting(
                                provider.commentPostingCommunityName(index),
                                provider.commentPostingId(index),
                              ),
                              onItemLongPressed: () {
                                debugPrint("Long Press!");
                              },
                            );
                          }
                          return InkWell(
                            onTap: () {
                              provider
                                  .fetchComments(
                                      userName: provider.userName,
                                      startAtId: provider.lastCommentId)
                                  .then(
                                (value) {
                                  if (!provider.hasMoreComment) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      // FIXME 하드코딩 문자
                                      const SnackBar(
                                        content: Text("마지막 댓글입니다."),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                            child: SizedBox(
                              height: 50,
                              child: Center(
                                child: provider.isLoadingComment
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
