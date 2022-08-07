import 'package:cuteshrew/api/cuteshrew_api_client.dart';
import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/notifiers/login_notifier.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/large_main_screen.dart';
import 'package:cuteshrew/widgets/small_main_screen.dart';
import 'package:cuteshrew/widgets/top_main_nav.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return ChangeNotifierProvider<LoginNotifier>(
      create: (context) =>
          LoginNotifier(api: context.read<CuteshrewApiClient>()),
      child: ProxyProvider<LoginNotifier, LoginState>(
        update: (context, value, previous) => value.value,
        child: Scaffold(
            key: scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: topMainNavigationBar(context, scaffoldKey),
            drawer: const Drawer(),
            body: const ResponsiveWidget(
              largeScreen: LargeMainScreen(),
              smallScreen: SmallMainScreen(),
            )),
      ),
    );
  }
}
