import 'package:cuteshrew/presentation/strings/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidgetFormPanel extends StatefulWidget {
  const LoginWidgetFormPanel({super.key});

  @override
  State<LoginWidgetFormPanel> createState() => _LoginWidgetFormPanelState();
}

class _LoginWidgetFormPanelState extends State<LoginWidgetFormPanel> {
  static const Color backgroundColor = Color(0xFFFFFFFF);
  static const Color highlightColor = Color(0xFF071a84);
  static const Color formBackgroundColor = Color(0xFFBBC4D9);
  static const Color formBorderColor = Color(0xFF3A54AA);
  static const Color textColor = Color(0xFF514b4c);

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: formBorderColor, width: 0));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;

  _login(String id, String password) {}

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: formBorderColor,
            ),
      ),
      child: Container(
        color: backgroundColor,
        padding: const EdgeInsets.symmetric(horizontal: 80),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "로그인",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: textColor),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _idController,
                      maxLines: 1,
                      cursorColor: formBorderColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                      },
                      decoration: InputDecoration(
                        border: _border,
                        enabledBorder: _border,
                        focusedBorder: _border,
                        errorBorder: _border,
                        label: Text(
                          "아이디",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: formBorderColor,
                                  ),
                          selectionColor: formBorderColor,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      maxLines: 1,
                      cursorColor: formBorderColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                      },
                      decoration: InputDecoration(
                        iconColor: formBorderColor,
                        focusColor: formBorderColor,
                        suffixIconColor: formBorderColor,
                        border: _border,
                        enabledBorder: _border,
                        focusedBorder: _border,
                        errorBorder: _border,
                        label: Text(
                          "비밀번호",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: formBorderColor,
                                  ),
                          selectionColor: formBorderColor,
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _showPassword = !_showPassword;
                            });
                          },
                          icon: Icon(
                            _showPassword
                                ? Icons.lock_outline
                                : Icons.lock_open_outlined,
                          ),
                        ),
                      ),
                      obscureText: !_showPassword,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: RichText(
                        text: TextSpan(
                          text: "비밀번호를 잊었습니다.",
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: formBorderColor,
                                  fontWeight: FontWeight.w700),
                          recognizer: TapGestureRecognizer()..onTap = () {},
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _login(_idController.text, _passwordController.text);
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, 50)),
                        backgroundColor: MaterialStateProperty.all(
                          highlightColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: const BorderSide(
                              color: formBorderColor,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "로그인",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: formBackgroundColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 32,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '아직 계정이 없으신가요?  ',
                      style: Theme.of(context)
                          .textTheme
                          .labelSmall!
                          .copyWith(color: formBackgroundColor),
                    ),
                    TextSpan(
                      text: '계정 생성하기',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: formBorderColor),
                      recognizer: TapGestureRecognizer()..onTap = () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
