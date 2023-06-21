import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/data/remote/api_cuteshrew.dart';
import 'package:cuteshrew/data/remote/user/user_req.dart';
import 'package:cuteshrew/data/remote/user/user_res.dart';
import 'package:cuteshrew/model/dto/user_dto.dart';

class UserModel {
  final ApiCuteShrew _apiCuteShrew = ApiCuteShrew();

  Future<NetworkResult<void>> createUser(UserCreateForm newUser) =>
      handleRequest(() async {
        return await _apiCuteShrew.requestSignUp(UserReq(
            nickname: newUser.name,
            email: newUser.name,
            password: newUser.password));
      });

  Future<NetworkResult<UserDetailInfo>> getUser(String userName) =>
      handleRequest(() async {
        final result = await _apiCuteShrew.getUserDetail(userName);
        return result.toDetailInfo();
      });
}
