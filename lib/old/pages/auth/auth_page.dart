import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/old/providers/login_notifier.dart';
import 'package:cuteshrew/old/pages/auth/large_auth_layout.dart';
import 'package:cuteshrew/old/pages/auth/small_auth_layout.dart';
import 'package:cuteshrew/presentation/common_widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return ProxyProvider<LoginNotifier, AuthenticationState>(
      update: (context, value, previous) => value.value,
      child: Scaffold(
          key: scaffoldKey,
          // extendBodyBehindAppBar: true,
          appBar: mainAppBar(context, scaffoldKey),
          drawer: const Drawer(),
          body: const ResponsiveWidget(
            largeScreen: LargeAuthLayout(),
            smallScreen: SmallAuthLayout(),
          )),
    );
  }
}
