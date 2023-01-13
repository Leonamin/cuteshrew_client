import 'package:cuteshrew/constants/values.dart';
import 'package:cuteshrew/core/data/datasource/hive/authentication_hive_datasource.dart';
import 'package:cuteshrew/core/data/datasource/remote/authentication_remote_datasource.dart';
import 'package:cuteshrew/core/data/dto/hive/login_token_hive_dto.dart';
import 'package:cuteshrew/core/data/repository/authentication_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/login_usecase.dart';
import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/presentation/config/route/web_advanced_router.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_provider.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/helpers/no_transition_builder.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // usePathUrlStrategy();
  setupLocator();
  await Hive.initFlutter();
  Hive.registerAdapter<LoginTokenHiveDTO>(LoginTokenHiveDTOAdapter());
  await Hive.openBox(hiveAuthBox);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<AuthenticationProvider>(create: (context) {
        final provider = AuthenticationProvider(
          loginUseCase: LoginUseCase(
            authenticationRepository: AuthenticationRepositoryImpl(
              authenticationRemoteDataSource: AuthenticationRemoteDataSource(),
              authenticationHiveDataSource: AuthenticationHiveDataSource(),
            ),
          ),
        );
        provider.initializeToken();
        return provider;
      }),
      ProxyProvider<AuthenticationProvider, AuthenticationState>(
          update: ((context, value, previous) => value.value))
    ],
    child: const MyApp(),
  ));
}

// const seedColor = Color(0xFFFFFF00);
const seedColor = Color(0xFFBCC0C0);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cute Shrew',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: seedColor,
          brightness: Brightness.light,
          // onPrimary: communityPrimaryColor,
          // primary: communitySecondaryTextColor,
        ),
        textTheme:
            GoogleFonts.notoSansNKoTextTheme(Theme.of(context).textTheme),
        // pageTransitionsTheme: PageTransitionsTheme(
        //   builders: kIsWeb
        //       ? {
        //           // No animations for every OS if the app running on the web
        //           for (final platform in TargetPlatform.values)
        //             platform: const NoTransitionsBuilder(),
        //         }
        //       : const {
        //           // handel other platforms you are targeting
        //         },
        // ),
      ),
      navigatorKey: locator<NavigationService>().navigatorKey,
      onGenerateRoute: generateRoute,
      initialRoute: Routes.HomePageRoute,
    );
  }
}
