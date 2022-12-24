import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/feature/home/page/home_page.dart';
import 'package:cuteshrew/helpers/no_transition_builder.dart';
import 'package:cuteshrew/providers/login_notifier.dart';
import 'package:cuteshrew/routing/router.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  // usePathUrlStrategy();
  setupLocator();
  runApp(MultiProvider(
    providers: [
      Provider<CuteshrewApiClient>(
        create: (_) => const CuteshrewApiClient(),
      ),
      ChangeNotifierProvider<LoginNotifier>(
        create: (context) =>
            LoginNotifier(api: context.read<CuteshrewApiClient>()),
      )
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
        pageTransitionsTheme: PageTransitionsTheme(
          builders: kIsWeb
              ? {
                  // No animations for every OS if the app running on the web
                  for (final platform in TargetPlatform.values)
                    platform: const NoTransitionsBuilder(),
                }
              : const {
                  // handel other platforms you are targeting
                },
        ),
      ),
      // onGenerateRoute: generateRoute,
      home: HomePage(),
    );
  }
}
