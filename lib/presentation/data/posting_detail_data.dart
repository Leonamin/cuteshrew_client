import 'package:cuteshrew/presentation/data/community_data.dart';
import 'package:cuteshrew/presentation/data/posting_data.dart';
import 'package:cuteshrew/presentation/data/user_data.dart';

// 모든 게시글 정보가 담긴 데이터
class PostingDetailData extends PostingData {
  final String body;
  final UserData? writer;
  final CommunityData? ownCommunity;

  const PostingDetailData({
    required int postId,
    required String title,
    required this.body,
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
        body,
        isLocked,
        publishedAt,
        updatedAt,
        writer,
        ownCommunity,
        commentCount,
      ];
}
