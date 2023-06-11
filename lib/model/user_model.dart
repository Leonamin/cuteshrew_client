import 'package:cuteshrew/data/network_result.dart';
import 'package:cuteshrew/model/dto/user_dto.dart';

abstract class UserModel {
  // 유저 생성하기
  Future<NetworkResult<void>> createUser({required UserCreateForm newUser});
  // 유저 기본 정보 가져오기
  Future<NetworkResult<UserDetailInfo>> getUser({required String userName});
}
