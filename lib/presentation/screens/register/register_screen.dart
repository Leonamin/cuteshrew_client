import 'package:cuteshrew/core/data/datasource/remote/user_remote_datasource.dart';
import 'package:cuteshrew/core/data/repository/user_repository_impl.dart';
import 'package:cuteshrew/core/domain/usecase/signin_usecase.dart';
import 'package:cuteshrew/presentation/screens/register/providers/register_provider.dart';
import 'package:cuteshrew/presentation/screens/register/widgets/register_form_panel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
  final Function()? changeToLogin;
  const RegisterScreen({super.key, this.changeToLogin});

  _showCompleted(context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      // FIXME 하드코딩 문장
      const SnackBar(
        content: Text("회원가입에 성공하였습니다."),
        backgroundColor: Colors.green,
      ),
    );
  }

  _showError(context) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        // FIXME 하드코딩 문장
        content: Text("회원가입에 실패하였습니다."),
        backgroundColor: Colors.red,
      ),
    );
  }

  _checkState(RegisterState state, BuildContext context) {
    if (state == RegisterState.COMPLETED) {
      _showCompleted(context);
      if (changeToLogin != null) {
        changeToLogin!();
      }
    } else {
      _showError(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RegisterProvider(
          signinUseCase: SigninUseCase(
              userRepository: UserRepositoryImpl(
                  userRemoteDataSource: UserRemoteDataSource()))),
      builder: (context, child) {
        return RegisterFormPanel(
          changeToLogin: changeToLogin,
          register: (data) => context
              .read<RegisterProvider>()
              .postSignIn(data)
              .then((state) => _checkState(state, context)),
        );
      },
    );
  }
}
