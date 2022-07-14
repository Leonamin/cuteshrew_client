import 'package:cuteshrew/layout/main_layout.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/provider/page_notifier.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:get_it/get_it.dart';

void main() {
  usePathUrlStrategy();
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider(create: (_) => PageNotifier())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Cute Shrew',
        theme: ThemeData(
          primarySwatch: Colors.green,
          textTheme: GoogleFonts.mulishTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: Colors.black),
        ),
        home: MainLayout());
  }
}
