part of '../user_dto.dart';

class UserDetailInfo extends _BaseUser {
  final int postingCount;
  final int commentCount;
  final String introduction;
  const UserDetailInfo({
    required String name,
    required String email,
    String? profileImageUrl,
    required this.postingCount,
    required this.commentCount,
    required this.introduction,
  }) : super(name: name, email: email, profileImageUrl: profileImageUrl);

  @override
  List<Object?> get props => [
        ...super.props,
        postingCount,
        commentCount,
        introduction,
      ];
}
