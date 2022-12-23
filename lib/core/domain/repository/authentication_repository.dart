import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  // 자체 저장으로 가지고 있는 토큰 가져오기
  Future<Either<Failure, LoginTokenEntity>> getToken({
    required String nickname,
  });

  // 저장된 토큰 지우기
  Future<Either<Failure, LoginTokenEntity>> deleteToken({
    required String nickname,
  });

  // 새로운 토큰 가져오기
  Future<Either<Failure, LoginTokenEntity>> requestLogin({
    required String nickname,
    required String password,
  });
}
