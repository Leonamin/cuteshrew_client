import 'package:equatable/equatable.dart';

// 프레젠테이션 계층에서 사용할 커뮤니티 데이터 기본 구조
abstract class CommunityData extends Equatable {
  final String communityName;
  final String communityShowName;
  final int postingCount;

  const CommunityData({
    required this.communityName,
    required this.communityShowName,
    required this.postingCount,
  });

  @override
  List<Object?> get props => [
        communityName,
        communityShowName,
        postingCount,
      ];
}
