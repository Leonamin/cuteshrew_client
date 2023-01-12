import 'package:cuteshrew/presentation/providers/authentication/authentication_provider.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/screens/auth/widgets/login_widget_form_panel.dart';
import 'package:cuteshrew/presentation/screens/auth/widgets/login_widget_info_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandedLoginWidget extends StatefulWidget {
  const ExpandedLoginWidget({super.key});

  @override
  State<ExpandedLoginWidget> createState() => _ExpandedLoginWidgetState();
}

class _ExpandedLoginWidgetState extends State<ExpandedLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(builder: (context, state, child) {
      if (state is AuthorizedState) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.read<AuthenticationProvider>().navigateAfterSiginIn();
        });
      }

      return Center(
        child: SingleChildScrollView(
          child: Container(
            height: 640,
            width: 1080,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              color: Colors.grey,
            ),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: LoginWidgetFormPanel(
                    login: (id, password, keepLogin) {
                      context
                          .read<AuthenticationProvider>()
                          .login(id, password);
                    },
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: LoginWidgetInfoPanel(),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
