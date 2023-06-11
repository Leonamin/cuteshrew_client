part of '../user_dto.dart';

class UserSummaryInfo extends _BaseUser {
  const UserSummaryInfo({
    required String name,
    required String email,
    String? profileImageUrl,
  }) : super(
          name: name,
          email: email,
          profileImageUrl: profileImageUrl,
        );
}
