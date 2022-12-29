import 'package:cuteshrew/presentation/data/community_data.dart';
import 'package:cuteshrew/presentation/data/posting_data.dart';

// 미리보기 정보만 가진 커뮤니티 데이터
class CommunityPreviewData extends CommunityData {
  final List<PostingData>? postings;

  const CommunityPreviewData({
    required super.communityName,
    required super.communityShowName,
    required super.postingCount,
    required this.postings,
  });

  @override
  List<Object?> get props =>
      super.props +
      [
        postings,
      ];
}
