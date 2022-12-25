import 'package:cuteshrew/presentation/data/community_data.dart';
import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/data/user_data.dart';

// 미리보기 정보만 담긴 게시글 데이터
class PostingPreviewData extends PostingData {
  final UserData writer;
  final CommunityData ownCommunity;

  const PostingPreviewData({
    required int postId,
    required String title,
    required bool isLocked,
    required int publishedAt,
    required int updatedAt,
    required this.writer,
    required this.ownCommunity,
    required int commentCount,
  }) : super(
          postId: postId,
          title: title,
          isLocked: isLocked,
          publishedAt: publishedAt,
          updatedAt: updatedAt,
          commentCount: commentCount,
        );

  @override
  List<Object?> get props => [
        postId,
        title,
        isLocked,
        publishedAt,
        updatedAt,
        writer,
        ownCommunity,
        commentCount,
      ];
}
