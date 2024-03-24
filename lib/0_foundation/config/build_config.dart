import 'package:flutter/foundation.dart';

class BuildConfig {
  static String name = '귀여운 땃쥐';

  static const List<String> _cuteshrewUrl = [
    'http://cuteshrew-api.cuteshrew.xyz',
    'http://cuteshrew-api.cuteshrew.xyz',
    'http://cuteshrew-api.cuteshrew.xyz',
  ];

  static String get cuteshrewUrl => _cuteshrewUrl[_mode];

  static int get _mode => kReleaseMode
      ? 2
      : kProfileMode
          ? 1
          : 0;
}
