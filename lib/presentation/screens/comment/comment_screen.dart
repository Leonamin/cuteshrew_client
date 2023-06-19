import 'package:cuteshrew/config/constants/values.dart';
import 'package:cuteshrew/core/data/datasource/remote/comment_remote_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/posting_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/comment_repository_impl.dart';
import 'package:cuteshrew/core/data/repository/posting_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/delete_comment_usecase.dart';
import 'package:cuteshrew/core/domain/usecase/show_posting_page_usecase.dart';
import 'package:cuteshrew/presentation/screens/comment/loaded_comment_screen.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_provider.dart';
import 'package:cuteshrew/presentation/screens/comment/providers/comment_page_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommentScreen extends StatelessWidget {
  final String communityName;
  final int postId;
  final int? currentPageNum;

  const CommentScreen({
    Key? key,
    required this.communityName,
    required this.postId,
    this.currentPageNum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        final notifier = CommentPageProvider(
          postId: postId,
          communityName: communityName,
          currentPageNum: currentPageNum ?? 1,
          countPerPage: defaultCommentsCountPerPage,
          // TODO 경량화 필요 ShowCommentPageUseCase로 따로 떼져야함
          postingPageUseCase: ShowPostingPageUseCase(
              postingRepository: PostingRepositoryImpl(
                postingRemoteDataSource: PostingRemoteDataSource(),
              ),
              commentRepository: CommentRepositoryImpl(
                commentRemoteDatasource: CommentRemoteDataSource(),
              )),
          deleteCommentUseCase: DeleteCommentUseCase(
              commentRepository: CommentRepositoryImpl(
            commentRemoteDatasource: CommentRemoteDataSource(),
          )),
        );
        notifier.getCommentPage(currentPageNum ?? 1);
        return notifier;
      },
      child: ProxyProvider<CommentPageProvider, CommentPageState>(
        update: (context, value, previous) => value.value,
        child: Consumer<CommentPageState>(builder: (context, state, child) {
          if (state is LoadedCommentPageState) {
            return LoadedCommentScreen(
              communityName: state.communityName,
              postId: postId,
              currentPageNum: state.currentPageNum,
              countPerPage: state.countPerPage,
              comments: state.commentDataList,
              // TODO 리스트 버튼 사용법이 좀 너무 복잡한거 같은데 나중에 손봐야함
              onPageButtonPressed: (int index) {
                context.read<CommentPageProvider>().getCommentPage(index);
              },
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
