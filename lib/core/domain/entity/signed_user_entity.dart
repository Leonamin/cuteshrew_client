import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/user_entity.dart';
import 'package:equatable/equatable.dart';

// 로그인 된 유저가 가질 정보
class SignedUserEntity extends Equatable {
  final UserEntity userInfo;
  final LoginTokenEntity loginTokenEntity;

  const SignedUserEntity({
    required this.userInfo,
    required this.loginTokenEntity,
  });

  @override
  List<Object?> get props => [
        userInfo,
        loginTokenEntity,
      ];
}
