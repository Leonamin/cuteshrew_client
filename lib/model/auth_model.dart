import 'package:cuteshrew/data/hive/auth/login_token_hive.dart';
import 'package:cuteshrew/data/hive/hive_helper.dart';
import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/data/remote/api_cuteshrew.dart';
import 'package:cuteshrew/data/remote/auth/login_token_res.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:cuteshrew/model/dto/user_dto.dart';

class AuthModel {
  final ApiCuteShrew _apiCuteShrew = ApiCuteShrew();
  final HiveHelper _hiveHelper = HiveHelper();

  // 새로운 토큰 가져오기
  Future<NetworkResult<LoginToken>> requestLogin(
    String nickname,
    String password,
  ) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.requestLogin(nickname, password);
        return result.toDto();
      });

  // 로그인된 유저 정보 가져오기
  Future<NetworkResult<SignedUserInfo>> getSignedUser() =>
      handleRequest(() async {
        LoginTokenHive result = _hiveHelper.getToken();
        return result.toSignedUser();
      });

  // 로그인된 유저 정보 저장하기
  Future<NetworkResult<SignedUserInfo>> setSignedUser(
          SignedUserInfo signedUserinfo) =>
      handleRequest(() async {
        await _hiveHelper.setToken(
          authTokenDTO: LoginTokenHive(
              name: signedUserinfo.userInfo.name,
              email: signedUserinfo.userInfo.email,
              accessToken: signedUserinfo.loginToken.accessToken,
              tokenType: signedUserinfo.loginToken.tokenType),
        );
        return signedUserinfo;
      });

  // 로그아웃된 유저 정보 지우기
  Future<NetworkResult<void>> deleteSignedUser() => handleRequest(() {
        return _hiveHelper.deleteToken();
      });
}
