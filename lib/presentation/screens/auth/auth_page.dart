import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/auth/large_auth_layout.dart';
import 'package:cuteshrew/presentation/screens/auth/small_auth_layout.dart';
import 'package:cuteshrew/presentation/widgets/main_app_bar/main_app_bar.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        // extendBodyBehindAppBar: true,
        appBar: mainAppBar(context, scaffoldKey),
        drawer: const Drawer(),
        body: const ResponsiveWidget(
          largeScreen: LargeAuthLayout(),
          smallScreen: SmallAuthLayout(),
        ));
  }
}
