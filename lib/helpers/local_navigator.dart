import 'package:cuteshrew/routing/router.dart';
import 'package:cuteshrew/routing/routes.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:cuteshrew/services/navigation_service.dart';
import 'package:flutter/cupertino.dart';

Navigator localNavigator() => Navigator(
      key: locator<NavigationService>().key,
      initialRoute: CommunityHomePageRoute,
      onGenerateRoute: generateRoute,
    );
