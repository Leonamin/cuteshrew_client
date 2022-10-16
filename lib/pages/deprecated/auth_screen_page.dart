import 'package:cuteshrew/pages/deprecated/login_layout.dart';
import 'package:cuteshrew/service_locator.dart';
import 'package:cuteshrew/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:provider/provider.dart';

class AuthScreenPage extends StatelessWidget {
  const AuthScreenPage({Key? key}) : super(key: key);

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
        locator<NavigationService>().pop();
      }
      //TODO
      // if (state is AuthorizationFailedState) {
      //   //TODO 실패 알람
      // }
      return Container();
    });
  }
}
