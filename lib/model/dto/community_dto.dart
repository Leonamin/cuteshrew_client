import 'package:equatable/equatable.dart';

part 'community/community_info.dart';

abstract class _BaseCommunity extends Equatable {
  final String communityName;
  final String communityShowName;
  final int postingCount;

  const _BaseCommunity({
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
