import 'package:cuteshrew/common/build_config.dart';
import 'package:cuteshrew/config/constants/values.dart';
import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:cuteshrew/presentation/config/route/web_advanced_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:cuteshrew/presentation/config/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  await Hive.initFlutter();
  Hive.registerAdapter<LoginTokenHiveDTO>(LoginTokenHiveDTOAdapter());
  await Hive.openBox(hiveAuthBox);
  runApp(MultiProvider(
    providers: [],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: BuildConfig.appName,
      theme: ThemeData(
        useMaterial3: true,
      ),
      onGenerateRoute: generateRoute,
      initialRoute: Routes.HomePageRoute,
    );
  }
}
