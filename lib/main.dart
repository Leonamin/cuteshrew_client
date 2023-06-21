import 'package:cuteshrew/common/build_config.dart';
import 'package:cuteshrew/data/hive/hive_helper.dart';
import 'package:cuteshrew/presentation/config/route/web_advanced_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:cuteshrew/presentation/config/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  await HiveHelper.init();
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
