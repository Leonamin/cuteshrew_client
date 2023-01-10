import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthenticationHiveDataSource {
  final box = Hive.box(hiveAuthBox);
  // 나중에 이름을 정하겠지만 __으로 시작하는 이름은 없게할 예정
  // 이게 기본 토큰값이다.
  final _token = "__token";

  Future<LoginTokenHiveDTO> getToken({String? nameKey}) async {
    final LoginTokenHiveDTO? result = box.get(nameKey ?? _token);
    if (result == null) {
      throw NullThrownError();
    }
    return result;
  }

  Future<void> setToken({
    String? nameKey,
    required LoginTokenHiveDTO authTokenDTO,
  }) async {
    box.put(nameKey ?? _token, authTokenDTO);
  }

  Future<void> deleteToken({String? nameKey}) async {
    box.delete(nameKey ?? _token);
  }
}
