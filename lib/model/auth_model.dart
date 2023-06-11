import 'package:cuteshrew/core/domain/entity/signed_user_entity.dart';
import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';

abstract class AuthModel {
  // 로그인 토큰 저장하기
  Future<NetworkResult<LoginToken>> saveToken({
    required int userId,
    required LoginToken loginTokenEntity,
  });

  // 저장한 토큰 가져오기
  Future<NetworkResult<LoginToken>> getToken({
    required String nickname,
  });

  // 저장된 토큰들 가져오기
  Future<NetworkResult<List<LoginToken>>> getTokenList();

  // 저장된 토큰 지우기
  Future<NetworkResult<void>> deleteToken({
    required String nickname,
  });

  // 모든 토큰 지우기
  Future<NetworkResult<void>> cleanTokens();

  // 새로운 토큰 가져오기
  Future<NetworkResult<LoginToken>> requestLogin({
    required String nickname,
    required String password,
  });

  // 로그인된 유저 정보 가져오기
  Future<NetworkResult<SignedUserEntity>> getSignedUser();

  // 로그인된 유저 정보 저장하기
  Future<NetworkResult<SignedUserEntity>> setSignedUser(
      {required SignedUserEntity signedUserEntity});
  // 로그아웃된 유저 정보 지우기
  Future<NetworkResult<void>> deleteSignedUser();
}
