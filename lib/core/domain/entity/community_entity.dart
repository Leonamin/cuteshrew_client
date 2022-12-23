import 'package:equatable/equatable.dart';

// 커뮤티니 정보가 있는 엔티티
class CommunityEntity extends Equatable {
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
