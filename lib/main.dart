import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/pages/auth_page.dart';
import 'package:cuteshrew/pages/community_page.dart';
import 'package:cuteshrew/pages/post_editor_page.dart';
import 'package:cuteshrew/pages/posting_page.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/provider/page_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/home_page.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() {
  usePathUrlStrategy();
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
      builder: (context, child) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, child!),
          maxWidth: 1200,
          minWidth: 450,
          defaultScale: true,
          breakpoints: [
            const ResponsiveBreakpoint.resize(450, name: MOBILE),
            const ResponsiveBreakpoint.autoScale(800, name: TABLET),
            const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: const Color(0xFFF5F5F5))),
      title: 'Cute Shrew',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Consumer<PageNotifier>(
        builder: (context, pageNotifier, child) {
          return Navigator(
            pages: [
              MaterialPage(
                  key: const ValueKey(HomePage.pageName), child: HomePage()),
              if (pageNotifier.currentPage == CommunityPage.pageName)
                MaterialPage(
                    key: const ValueKey(CommunityPage.pageName),
                    child: CommunityPage(
                        pageNotifier.args as Map<String, Community>)),
              if (pageNotifier.currentPage == PostEditorPage.pageName)
                MaterialPage(
                    key: const ValueKey(PostEditorPage.pageName),
                    child: PostEditorPage(
                        pageNotifier.args as Map<String, dynamic>)),
              if (pageNotifier.currentPage == PostingPage.pageName)
                MaterialPage(
                    key: const ValueKey(PostingPage.pageName),
                    child:
                        PostingPage(pageNotifier.args as Map<String, dynamic>)),
              if (pageNotifier.currentPage == AuthPage.pageName) AuthPage(),
            ],
            onPopPage: (route, result) {
              if (!route.didPop(result)) {
                return false;
              }
              return true;
            },
          );
        },
      ),
    );
  }
}
