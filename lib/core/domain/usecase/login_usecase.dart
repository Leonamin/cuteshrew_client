import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/repository/authentication_repository.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

class LoginUseCase {
  late AuthenticationRepository authenticationRepository;

  LoginUseCase({required this.authenticationRepository});

  // 로그인 요청을 보내서 토큰을 가져온다.
  Future<Either<Failure, LoginTokenEntity>> call(
      String nickname, String password) {
    return authenticationRepository.requestLogin(
        nickname: nickname, password: password);
  }
}
