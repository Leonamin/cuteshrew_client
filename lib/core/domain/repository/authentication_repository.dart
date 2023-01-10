import 'package:cuteshrew/core/domain/entity/login_token_entity.dart';
import 'package:cuteshrew/core/domain/entity/signed_user_entity.dart';
import 'package:cuteshrew/core/resources/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  // 로그인 토큰 저장하기
  Future<Either<Failure, LoginTokenEntity>> saveToken({
    required String nickname,
    required LoginTokenEntity loginTokenEntity,
  });

  // 저장한 토큰 가져오기
  Future<Either<Failure, LoginTokenEntity>> getToken({
    required String nickname,
  });

  // 저장된 토큰들 가져오기
  Future<Either<Failure, List<LoginTokenEntity>>> getTokenList();

  // 저장된 토큰 지우기
  Future<Either<Failure, void>> deleteToken({
    required String nickname,
  });

  // 모든 토큰 지우기
  Future<Either<Failure, void>> cleanTokens();

  // 새로운 토큰 가져오기
  Future<Either<Failure, LoginTokenEntity>> requestLogin({
    required String nickname,
    required String password,
  });

  // 로그인된 유저 정보 가져오기
  Future<Either<Failure, SignedUserEntity>> getSignedUser();
  // 로그인된 유저 정보 저장하기
  Future<Either<Failure, SignedUserEntity>> setSignedUser();
  // 로그아웃된 유저 정보 지우기
  Future<Either<Failure, SignedUserEntity>> deleteSignedUser();
}
