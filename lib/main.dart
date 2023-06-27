import 'package:cuteshrew/common/build_config.dart';
import 'package:cuteshrew/data/hive/hive_helper.dart';
import 'package:cuteshrew/view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  await HiveHelper.init();
  runApp(const ProviderScope(
    child: MyApp(),
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
      home: const HomeView(),
    );
  }
}
