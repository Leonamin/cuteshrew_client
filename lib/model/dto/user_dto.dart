import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:equatable/equatable.dart';

part 'user/user_summary.dart';
part 'user/user_detail.dart';
part 'user/user_create_form.dart';
part 'user/signed_user_info.dart';

abstract class _BaseUser extends Equatable {
  const _BaseUser({
    required this.name,
    required this.email,
    this.profileImageUrl,
  });

  final String name;
  final String email;
  final String? profileImageUrl;

  @override
  List<Object?> get props => [
        name,
        email,
        profileImageUrl,
      ];
}
