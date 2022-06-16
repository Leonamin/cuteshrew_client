import 'dart:io';

import 'package:cuteshrew/model/models.dart';
import 'package:cuteshrew/network/http_service.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/strings/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class AuthPage extends Page {
  static const pageNmae = 'AuthPage';
  @override
  Route createRoute(BuildContext context) {
    return MaterialPageRoute(
        settings: this, builder: (context) => AuthWidget());
  }
}

class AuthWidget extends StatefulWidget {
  AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // UI setting values
  static const double _cornerRadius = 8.0;

  static const int _textLengthLimit = 20;

  static const double _textFormInterval = 8.0;

  // Login & Register TextForm
  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_cornerRadius),
      borderSide: const BorderSide(color: Colors.transparent, width: 0));

  final OutlineInputBorder _errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_cornerRadius),
      borderSide: const BorderSide(color: Colors.redAccent, width: 0));

  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cPasswordController = TextEditingController();

  // Animation Settings
  final Duration _duration = const Duration(microseconds: 400);
  final Curve _curve = Curves.fastOutSlowIn;

  // Login & Register Select Button
  ButtonStyle flatButtonStyle = TextButton.styleFrom(
      padding: const EdgeInsets.all(20),
      backgroundColor: Colors.white54,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(_cornerRadius)));

  bool isRegister = false;

  // Network
  HttpService httpService = HttpService();
  // late Future<String> signin;

  bool isLoginFailed = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: Colors.indigo,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(
        //         'image.gif',
        //       ),
        //       fit: BoxFit.cover),
        // ),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: ChangeNotifierProvider(
              create: (BuildContext context) => LoginProvider(),
              child: SafeArea(
                child: Form(
                  key: _formKey,
                  child: ListView(
                    reverse: true,
                    padding: const EdgeInsets.all(16),
                    children: [
                      const SizedBox(
                        height: _textFormInterval,
                      ),
                      ButtonBar(
                        children: [
                          AnimatedContainer(
                              height: isLoginFailed ? 60 : 0,
                              duration: _duration,
                              curve: _curve,
                              child: Text("로그인 실패 데스우")),
                          const SizedBox(
                            height: _textFormInterval,
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isRegister = false;
                                isLoginFailed = false;
                                _formKey.currentState?.reset();
                              });
                            },
                            child: Text(
                              Strings.login,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isRegister
                                      ? FontWeight.w400
                                      : FontWeight.w600,
                                  color: isRegister
                                      ? Colors.black38
                                      : Colors.black87),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isRegister = true;
                                isLoginFailed = false;
                                _formKey.currentState?.reset();
                              });
                            },
                            child: Text(
                              Strings.register,
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: isRegister
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isRegister
                                      ? Colors.black87
                                      : Colors.black38),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: _textFormInterval,
                      ),
                      _buildTextFormField(
                          Strings.labelNickname, _nicknameController),
                      const SizedBox(
                        height: _textFormInterval,
                      ),
                      AnimatedContainer(
                          height: isRegister ? 60 : 0,
                          duration: _duration,
                          curve: _curve,
                          child: _buildTextFormField(
                              Strings.labelEmail, _emailController)),
                      const SizedBox(
                        height: _textFormInterval,
                      ),
                      _buildTextFormField(
                          Strings.labelPassword, _passwordController),
                      const SizedBox(
                        height: _textFormInterval,
                      ),
                      AnimatedContainer(
                        height: isRegister ? 60 : 0,
                        duration: _duration,
                        curve: _curve,
                        child: _buildTextFormField(
                            Strings.labelCPassword, _cPasswordController),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      TextButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              var result = await httpService.postLogin(
                                  _nicknameController.text,
                                  _passwordController.text);
                            } on Exception {
                              setState(() {
                                isLoginFailed = true;
                              });
                            }
                          }

                          // context
                          //     .read<LoginProvider>()
                          //     .setToken(result.accessToken);
                          // Navigator.pop(context);
                        },
                        style: flatButtonStyle,
                        child: Text(
                          isRegister ? Strings.register : Strings.login,
                          style: const TextStyle(
                              color: Colors.black, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const Divider(
                        height: 33,
                        thickness: 1,
                        color: Colors.white,
                        indent: 16,
                        endIndent: 16,
                      ),
                      const SizedBox(
                        height: _textFormInterval * 8,
                      ),
                    ].reversed.toList(),
                  ),
                ),
              ),
            )),
      ),
    );
  }

  TextFormField _buildTextFormField(
      String labelText, TextEditingController controller) {
    return TextFormField(
      inputFormatters: [LengthLimitingTextInputFormatter(_textLengthLimit)],
      cursorColor: Colors.white,
      controller: controller,
      validator: (text) {
        if (isRegister) {
          // TODO 이메일 유효성 검사 추가
          if (controller == _emailController &&
              (text == null || text.isEmpty)) {
            return Strings.invalidEmailForm;
          }

          // TODO 비밀번호 유효성 검사 추가
          if (controller == _passwordController &&
              (text == null || text.isEmpty)) {
            return Strings.invalidPassword;
          }

          if (controller == _cPasswordController &&
              ((text == null || text.isEmpty) ||
                  controller.text != _passwordController.text)) {
            return Strings.invalidCPasswordForm;
          }

          if (text == null || text.isEmpty) {
            return Strings.emptyTextForm;
          }
        }
        if (((controller != _emailController) &&
                (controller != _cPasswordController)) &&
            (text == null || text.isEmpty)) {
          return Strings.emptyTextForm;
        }

        return null;
      },
      decoration: InputDecoration(
          labelText: labelText,
          border: _border,
          errorBorder: _errorBorder,
          enabledBorder: _border,
          focusedBorder: _border,
          filled: true,
          fillColor: Colors.black54,
          errorStyle: const TextStyle(
              color: Colors.redAccent, fontWeight: FontWeight.bold),
          labelStyle: const TextStyle(color: Colors.white)),
    );
  }
}
