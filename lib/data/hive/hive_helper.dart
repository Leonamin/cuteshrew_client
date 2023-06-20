import 'package:cuteshrew/config/constants/values.dart';
import 'package:cuteshrew/data/hive/auth/login_token_hive.dart';
import 'package:hive/hive.dart';

class HiveHelper {
  HiveHelper._();
  static final HiveHelper _instance = HiveHelper._();

  factory HiveHelper() {
    return _instance;
  }

  // 나중에 이름을 정하겠지만 __으로 시작하는 이름은 없게할 예정
  // 이게 기본 토큰값이다.
  final _token = "default";

  Future<LoginTokenHive> getToken({String? nameKey}) async {
    try {
      final box = await Hive.openBox(hiveAuthBox);
      final LoginTokenHive result = await box.get(nameKey ?? _token);
      await box.close();
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setToken({
    String? nameKey,
    required LoginTokenHive authTokenDTO,
  }) async {
    final box = await Hive.openBox(hiveAuthBox);

    box.put(nameKey ?? _token, authTokenDTO);
    await box.close();
  }

  Future<void> deleteToken({String? nameKey}) async {
    final box = await Hive.openBox(hiveAuthBox);
    box.delete(nameKey ?? _token);
    await box.close();
  }
}
