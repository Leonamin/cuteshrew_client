import 'package:cuteshrew/core/data/datasource/remote/community_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/community_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/show_community_page_usecase.dart';
import 'package:cuteshrew/presentation/data/posting_preview_data.dart';
import 'package:cuteshrew/presentation/screens/community/providers/community_page_provider.dart';
import 'package:cuteshrew/presentation/screens/community/providers/community_page_state.dart';
import 'package:cuteshrew/presentation/screens/home/provider/home_page_provider.dart';
import 'package:cuteshrew/presentation/screens/home/widgets/community_card.dart';
import 'package:cuteshrew/presentation/screens/home/widgets/horizontal_posting_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommunityPanel extends StatelessWidget {
  final String communityName;
  final int? loadCount;
  const CommunityPanel({
    Key? key,
    required this.communityName,
    this.loadCount,
  }) : super(key: key);

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
            currentPageNum: 1,
            countPerPage: loadCount ?? 5);
        notifier.getCommunityInfo(1);
        return notifier;
      },
      child: ProxyProvider<CommunityPageProvider, CommunityPageState>(
        update: (context, value, previous) => value.value,
        child: Consumer<CommunityPageState>(builder: (context, value, child) {
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
        }),
      ),
    );
  }
}

class LoadedDataCommunityScreen extends StatelessWidget {
  final String communityName; // 현재 커뮤니티 정보
  final String communityShowName;
  final int postingCount;
  final List<PostingPreviewData> postings;

  final int currentPageNum; // 현재 페이지 번호
  final int countPerPage; // 한 페이지에 표시할 게시물 수

  const LoadedDataCommunityScreen({
    super.key,
    required this.communityName,
    required this.communityShowName,
    required this.postingCount,
    required this.postings,
    required this.currentPageNum,
    required this.countPerPage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: CommunityCard(
        communityShowName: communityShowName,
        onTitlePressed: () {
          context.read<HomePageProvider>().navigateToCommunity(communityName);
        },
        postingPanel: postings
            .map(
              (posting) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16.0,
                ),
                child: HorizontalPostingItem(
                  title: posting.title,
                  writerName: posting.writer?.name ?? "nickname",
                  publishedAt: posting.publishedAt,
                  commentCount: posting.commentCount.toString(),
                  onPostingPressed: () {
                    context
                        .read<HomePageProvider>()
                        .navigateToPosting(communityName, posting.postId);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
