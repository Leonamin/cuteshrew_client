import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/notifiers/login_notifier.dart';
import 'package:cuteshrew/pages/home/large_home_layout.dart';
import 'package:cuteshrew/pages/home/small_home_layout.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/main_app_bar.dart';
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
          appBar: mainAppBar(context, scaffoldKey),
          drawer: const Drawer(),
          body: const ResponsiveWidget(
            largeScreen: LargeHomeLayout(),
            smallScreen: SmallHomeLayout(),
          )),
    );
  }
}