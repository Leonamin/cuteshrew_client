import 'package:cuteshrew/config/constants/values.dart';
import 'package:cuteshrew/data/hive/auth/login_token_hive.dart';
import 'package:cuteshrew/model/dto/login_dto.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveHelper {
  HiveHelper._();
  static final HiveHelper _instance = HiveHelper._();

  factory HiveHelper() {
    return _instance;
  }

  static const String _boxNameAuth = "auth_box";

  static const _token = "default";

  final _authBox = Hive.box<LoginTokenHive>(_boxNameAuth);

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register Adapters for Custom Hive Classes
    Hive.registerAdapter<LoginTokenHive>(LoginTokenHiveDTOAdapter());

    // Open Hive Boxes
    await Hive.openBox(hiveAuthBox);
  }

  Future<LoginToken> get loginToken async => (await getToken()).toTokenDto();

  Future<LoginTokenHive> getToken({String? nameKey}) async {
    final result = _authBox.get(nameKey ?? _token);
    if (result == null) {
      throw Exception("Token is null");
    }
    return result;
  }

  Future<void> setToken({
    String? nameKey,
    required LoginTokenHive authTokenDTO,
  }) async {
    await _authBox.put(nameKey ?? _token, authTokenDTO);
  }

  Future<void> deleteToken({String? nameKey}) async {
    await _authBox.delete(nameKey ?? _token);
  }
}
