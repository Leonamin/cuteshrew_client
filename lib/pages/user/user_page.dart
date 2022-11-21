import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/pages/user/small_user_screen.dart';
import 'package:cuteshrew/providers/login_notifier.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/main_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatelessWidget {
  // 둘중 하나 선택할 수 있게
  // ../user/id/222
  // ../user/name/asdasd
  int? userId;
  String? userName;
  UserPage({super.key, this.userId, this.userName});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return ProxyProvider<LoginNotifier, LoginState>(
      update: (context, value, previous) => value.value,
      child: Scaffold(
          key: scaffoldKey,
          drawer: const Drawer(),
          body: ResponsiveWidget(
            largeScreen: SmallUserScreen(
              userId: userId,
              userName: userName,
            ),
            smallScreen: SmallUserScreen(
              userId: userId,
              userName: userName,
            ),
          )),
    );
  }
}
