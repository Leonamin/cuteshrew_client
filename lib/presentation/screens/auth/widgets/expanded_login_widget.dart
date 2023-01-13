import 'package:cuteshrew/presentation/providers/authentication/authentication_provider.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/screens/auth/widgets/login_widget_form_panel.dart';
import 'package:cuteshrew/presentation/screens/auth/widgets/login_widget_info_panel.dart';
import 'package:cuteshrew/presentation/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExpandedLoginWidget extends StatefulWidget {
  const ExpandedLoginWidget({super.key});

  @override
  State<ExpandedLoginWidget> createState() => _ExpandedLoginWidgetState();
}

class _ExpandedLoginWidgetState extends State<ExpandedLoginWidget> {
  bool isResgister = false;
  AuthenticationState? previewState = null;
  void changeLoginMode() {
    setState(() {
      isResgister = !isResgister;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(builder: (context, state, child) {
      if (state is UnauthorizedState) {
        if (previewState == null) {
          previewState = const UnauthorizedState();
        } else {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              // FIXME 하드코딩 문장
              content: Text("로그인 실패"),
              backgroundColor: Colors.red,
            ));
          });
        }
      }
      if (state is AuthorizedState) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            // FIXME 하드코딩 문장
            content: Text("로그인 성공"),
            backgroundColor: Colors.green,
          ));
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
                    child: Navigator(
                  pages: [
                    MaterialPage(
                      child: LoginWidgetFormPanel(
                        login: (id, password, keepLogin) {
                          context
                              .read<AuthenticationProvider>()
                              .login(id, password);
                        },
                        changeToRegister: changeLoginMode,
                      ),
                    ),
                    if (isResgister)
                      MaterialPage(
                        child: RegisterScreen(
                          changeToLogin: changeLoginMode,
                        ),
                      ),
                  ],
                  onPopPage: (route, result) {
                    if (!route.didPop(result)) {
                      return false;
                    }

                    return true;
                  },
                )),
                const Expanded(
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
