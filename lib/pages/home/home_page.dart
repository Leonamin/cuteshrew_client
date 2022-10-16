import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/notifiers/login_notifier.dart';
import 'package:cuteshrew/pages/home/large_home_screen.dart';
import 'package:cuteshrew/pages/home/small_home_screen.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/top_main_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return ProxyProvider<LoginNotifier, LoginState>(
      update: (context, value, previous) => value.value,
      child: Scaffold(
          key: scaffoldKey,
          // extendBodyBehindAppBar: true,
          appBar: topMainNavigationBar(context, scaffoldKey),
          drawer: const Drawer(),
          body: const ResponsiveWidget(
            largeScreen: LargeHomeScreen(),
            smallScreen: SmallHomeScreen(),
          )),
    );
  }
}
