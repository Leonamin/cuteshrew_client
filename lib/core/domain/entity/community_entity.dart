import 'package:equatable/equatable.dart';

// 커뮤니티 기본 정보가 담긴 엔티티
// 의존성 역전으로 영향 최소화시킨다.
abstract class CommunityEntity extends Equatable {
  final String communityName;
  final String communityShowName;
  final int postingCount;

  const CommunityEntity({
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
