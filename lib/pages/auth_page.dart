import 'package:cuteshrew/pages/auth_screen_page_widgets/login_layout.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AuthLayout();
  }
}

class AuthLayout extends StatelessWidget {
  const AuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginState>(builder: (context, state, child) {
      if (state is UnauthorizedState) {
        return LoginLayout(state: state);
      }
      if (state is RequestAuthorizationState) {
        return Container();
      }
      if (state is AuthorizedState) {
        Navigator.pop(context);
      }
      //TODO
      // if (state is AuthorizationFailedState) {
      //   //TODO 실패 알람
      // }
      return Container();
    });
  }
}
