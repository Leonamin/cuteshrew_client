import 'package:cuteshrew/core/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/authentication_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/login_usecase.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_provider.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/helpers/no_transition_builder.dart';
import 'package:cuteshrew/config/routing/router.dart';
import 'package:cuteshrew/config/routing/routes.dart';

void main() {
  // usePathUrlStrategy();
  setupLocator();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationProvider>(
        create: (context) => AuthenticationProvider(
          loginUseCase: LoginUseCase(
            authenticationRepository: AuthenticationRepositoryImpl(
              authenticationRemoteDataSource: AuthenticationRemoteDataSource(),
            ),
          ),
        ),
      ),
      ProxyProvider<AuthenticationProvider, AuthenticationState>(
          update: ((context, value, previous) => value.value))
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
      onGenerateRoute: generateRoute,
      initialRoute: Routes.HomePageRoute,
    );
  }
}
