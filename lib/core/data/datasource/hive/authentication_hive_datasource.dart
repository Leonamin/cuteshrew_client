import 'package:cuteshrew/config/constants/values.dart';
import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AuthenticationHiveDataSource {
  // 나중에 이름을 정하겠지만 __으로 시작하는 이름은 없게할 예정
  // 이게 기본 토큰값이다.
  final _token = "default";

  Future<LoginTokenHiveDTO> getToken({String? nameKey}) async {
    try {
      final box = await Hive.openBox(hiveAuthBox);
      final LoginTokenHiveDTO result = await box.get(nameKey ?? _token);
      await box.close();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setToken({
    String? nameKey,
    required LoginTokenHiveDTO authTokenDTO,
  }) async {
    final box = await Hive.openBox(hiveAuthBox);

    box.put(nameKey ?? _token, authTokenDTO);
    final LoginTokenHiveDTO result = await box.get(nameKey ?? _token);
    await box.close();
  }

  Future<void> deleteToken({String? nameKey}) async {
    final box = await Hive.openBox(hiveAuthBox);
    box.delete(nameKey ?? _token);
    await box.close();
  }
}
