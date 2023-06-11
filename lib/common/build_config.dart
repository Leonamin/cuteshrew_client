import 'package:flutter/foundation.dart';

class BuildConfig {
  static const List<String> _appNames = [
    '귀여운 땃쥐(개발)',
    '귀여운 땃쥐(테스트)',
    '귀여운 땃쥐',
  ];
  static String get appName => _appNames[_idx];

  static const List<String> _buildVariant = [
    'dev',
    'test',
    'prod',
  ];
  static String get buildVariant => _buildVariant[_idx];

  static const List<String> _cuteshrewApiAddresses = [
    'https://cuteshrew.xyz/apiv2/',
    'https://cuteshrew.xyz/apiv2/',
    'https://cuteshrew.xyz/apiv2/',
  ];
  static String get cuteshrewApiAddress => _cuteshrewApiAddresses[_idx];

  static int get _idx => kReleaseMode
      ? 2
      : kProfileMode
          ? 1
          : 0;
}
