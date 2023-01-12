import 'package:cuteshrew/presentation/config/constants/color.dart';
import 'package:cuteshrew/presentation/strings/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LoginWidgetFormPanel extends StatefulWidget {
  final Function(String id, String password, bool keepLogin)? login;
  final Function()? changeToRegister;
  const LoginWidgetFormPanel({
    super.key,
    this.login,
    this.changeToRegister,
  });

  @override
  State<LoginWidgetFormPanel> createState() => _LoginWidgetFormPanelState();
}

class _LoginWidgetFormPanelState extends State<LoginWidgetFormPanel> {
  static const double _formWidth = double.infinity;
  static const double _formHeight = 60;
  static const double _borderRadius = 8.0;

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: const BorderSide(color: authFormLightBlueColor, width: 0));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _showPassword = false;
  bool _keepLogin = false;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData().copyWith(
        unselectedWidgetColor: authFormCreamWhiteColor,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: authFormLightBlueColor,
            ),
      ),
      child: Container(
        color: authFormWhiteColor,
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
                          .copyWith(color: authFormTextColor),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    TextFormField(
                      controller: _idController,
                      maxLines: 1,
                      cursorColor: authFormLightBlueColor,
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
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: authFormLightBlueColor,
                                ),
                            selectionColor: authFormLightBlueColor,
                          ),
                          suffixIcon:
                              const Icon(Icons.person_outline_outlined)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _passwordController,
                      maxLines: 1,
                      cursorColor: authFormLightBlueColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                      },
                      decoration: InputDecoration(
                        iconColor: authFormLightBlueColor,
                        focusColor: authFormLightBlueColor,
                        suffixIconColor: authFormLightBlueColor,
                        border: _border,
                        enabledBorder: _border,
                        focusedBorder: _border,
                        errorBorder: _border,
                        label: Text(
                          "비밀번호",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: authFormLightBlueColor,
                                  ),
                          selectionColor: authFormLightBlueColor,
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
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 18,
                              height: 30,
                              child: Checkbox(
                                value: _keepLogin,
                                // 이걸 해주면 체크박스 근처 호버링 범위 표시 효과가 없어진다.
                                splashRadius: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  side: BorderSide(
                                    color: authFormCreamWhiteColor,
                                    width: 1,
                                  ),
                                ),
                                checkColor: authFormCreamWhiteColor,
                                activeColor: authFormLightBlueColor,
                                onChanged: (value) {
                                  setState(() {
                                    _keepLogin = !_keepLogin;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            RichText(
                              text: TextSpan(
                                text: "로그인 상태 유지",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelMedium!
                                    .copyWith(
                                      color: authFormCreamWhiteColor,
                                    ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    setState(() {
                                      _keepLogin = !_keepLogin;
                                    });
                                  },
                              ),
                            ),
                          ],
                        ),
                        RichText(
                          text: TextSpan(
                            text: "비밀번호를 잊었습니다.",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                    color: authFormLightBlueColor,
                                    fontWeight: FontWeight.w700),
                            recognizer: TapGestureRecognizer()..onTap = () {},
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.login != null) {
                            widget.login!(_idController.text,
                                _passwordController.text, _keepLogin);
                          }
                        }
                      },
                      style: ButtonStyle(
                        minimumSize: MaterialStateProperty.all(
                            const Size(double.infinity, _formHeight)),
                        backgroundColor: MaterialStateProperty.all(
                          authFormNavyBlueColor,
                        ),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(_borderRadius),
                            side: const BorderSide(
                              color: authFormLightBlueColor,
                            ),
                          ),
                        ),
                      ),
                      child: Text(
                        "로그인",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .copyWith(color: authFormCreamWhiteColor),
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
                          .copyWith(color: authFormCreamWhiteColor),
                    ),
                    TextSpan(
                      text: '계정 생성하기',
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge!
                          .copyWith(color: authFormLightBlueColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.changeToRegister,
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
