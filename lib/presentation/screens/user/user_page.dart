import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/screens/user/small_user_screen.dart';
import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  // 둘중 하나 선택할 수 있게
  // ../user/id/222
  // ../user/name/asdasd
  final String userName;
  const UserPage({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
    return Scaffold(
        key: scaffoldKey,
        drawer: const Drawer(),
        body: ResponsiveWidget(
          largeScreen: SmallUserScreen(
            userName: userName,
          ),
          smallScreen: SmallUserScreen(
            userName: userName,
          ),
        ));
  }
}
