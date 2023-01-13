import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/home/page/large_home_layout.dart';
import 'package:cuteshrew/presentation/screens/home/page/small_home_layout.dart';
import 'package:cuteshrew/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        appBar: mainAppBar(context, scaffoldKey),
        backgroundColor: Theme.of(context).colorScheme.primary,
        extendBodyBehindAppBar: true,
        drawer: const Drawer(),
        body: const ResponsiveWidget(
          largeScreen: LargeHomeLayout(),
          smallScreen: SmallHomeLayout(),
        ));
  }
}
