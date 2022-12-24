import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/feature/home/page/large_home_layout.dart';
import 'package:cuteshrew/feature/home/page/small_home_layout.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        // extendBodyBehindAppBar: true,
        drawer: const Drawer(),
        body: const ResponsiveWidget(
          largeScreen: LargeHomeLayout(),
          smallScreen: SmallHomeLayout(),
        ));
  }
}
