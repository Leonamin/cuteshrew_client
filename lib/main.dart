import 'package:cuteshrew/0_foundation/config/build_config.dart';
import 'package:cuteshrew/0_foundation/init_model.dart';
import 'package:cuteshrew/0_foundation/router/init_router.dart';
import 'package:cuteshrew/0_foundation/ui/color_palettes.dart';
import 'package:cuteshrew/3_view/home/home_view_model.dart';
import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeDateFormatting();

  usePathUrlStrategy();
  setupLocator();

  await Hive.initFlutter();
  Hive.registerAdapter<LoginTokenHiveDTO>(LoginTokenHiveDTOAdapter());
  await Hive.openBox(hiveAuthBox);

  runApp(
    ProviderScope(
      overrides: [
        homeViewModelProvider,
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: BuildConfig.name,
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          backgroundColor: ColorPaletts.white,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: ColorPaletts.primary4,
          background: ColorPaletts.white,
        ),
      ),
      routerConfig: initRouter(),
    );
  }
}
