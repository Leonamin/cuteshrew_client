import 'package:cuteshrew/0_foundation/router/common_page.dart';
import 'package:cuteshrew/0_foundation/router/common_routes.dart';
import 'package:cuteshrew/3_view/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GoRouter initRouter() {
  final rootNavigatorKey = GlobalKey<NavigatorState>();

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: CommonRoutes.home.path,
    routes: [
      GoRoute(
        path: CommonRoutes.home.path,
        name: CommonRoutes.home.name,
        pageBuilder: (context, state) =>
            const CommonPage(child: HomeView()).noTransition(),
      ),
    ],
  );
}
