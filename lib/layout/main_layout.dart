import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/widgets/large_main_screen.dart';
import 'package:cuteshrew/widgets/small_main_screen.dart';
import 'package:cuteshrew/widgets/top_main_nav.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        extendBodyBehindAppBar: true,
        appBar: topMainNavigationBar(context, scaffoldKey),
        drawer: const Drawer(),
        body: const ResponsiveWidget(
          largeScreen: LargeMainScreen(),
          smallScreen: SmallMainScreen(),
        ));
  }
}
