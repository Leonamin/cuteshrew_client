import 'package:cuteshrew/routing/router.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/services/navigation_service_impl.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator() => Navigator(
      key: NavigationServiceImpl.navigatorKey,
      initialRoute: CommunityHomePageRoute,
      onGenerateRoute: generateRoute,
    );
