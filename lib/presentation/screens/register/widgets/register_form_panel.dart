import 'package:cuteshrew/presentation/config/constants/color.dart';
import 'package:cuteshrew/presentation/data/user_create_data.dart';
import 'package:cuteshrew/presentation/helpers/responsiveness.dart';
import 'package:cuteshrew/presentation/strings/strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class RegisterFormPanel extends StatefulWidget {
  final Function(UserCreateData data)? register;
  final Function()? changeToLogin;
  const RegisterFormPanel({super.key, this.register, this.changeToLogin});

  @override
  State<RegisterFormPanel> createState() => _RegisterFormPanelState();
}

class _RegisterFormPanelState extends State<RegisterFormPanel> {
  static const double _formWidth = double.infinity;
  static const double _formHeight = 60;
  static const double _borderRadius = 8.0;

  final OutlineInputBorder _border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(_borderRadius),
      borderSide: const BorderSide(color: authFormLightBlueColor, width: 0));

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _checkPasswordController =
      TextEditingController();

  bool _showPassword = false;
  bool _agreeTerms = false;

  @override
  Widget build(BuildContext context) {
    final horizontalPadding = ResponsiveWidget.isSmallScreen(context)
        ? const EdgeInsets.symmetric(horizontal: 30)
        : (ResponsiveWidget.isMediumScreen(context)
            ? const EdgeInsets.symmetric(horizontal: 50)
            : const EdgeInsets.symmetric(horizontal: 80));
    return Theme(
      data: ThemeData().copyWith(
        unselectedWidgetColor: authFormCreamWhiteColor,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: authFormLightBlueColor,
            ),
      ),
      child: Container(
        color: authFormWhiteColor,
        padding: horizontalPadding,
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
                      "회원가입",
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(color: authFormTextColor),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    // 아이디 입력
                    TextFormField(
                      controller: _idController,
                      maxLines: 1,
                      cursorColor: authFormLightBlueColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                        return null;
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
                                    color: authFormLightBlueColor,
                                  ),
                          selectionColor: authFormLightBlueColor,
                        ),
                        suffixIcon: const Icon(Icons.person_outline_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // 이메일 입력
                    TextFormField(
                      controller: _emailController,
                      maxLines: 1,
                      cursorColor: authFormLightBlueColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                        bool emailValid = RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(text);
                        if (!emailValid) {
                          // FIXME 하드코딩 문장
                          return "이메일이 아니당";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: _border,
                        enabledBorder: _border,
                        focusedBorder: _border,
                        errorBorder: _border,
                        label: Text(
                          "이메일",
                          style:
                              Theme.of(context).textTheme.labelLarge!.copyWith(
                                    color: authFormLightBlueColor,
                                  ),
                          selectionColor: authFormLightBlueColor,
                        ),
                        suffixIcon: const Icon(Icons.alternate_email_outlined),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    // 비밀번호 입력
                    TextFormField(
                      controller: _passwordController,
                      maxLines: 1,
                      cursorColor: authFormLightBlueColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                        return null;
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
                      height: 20,
                    ),
                    // 비밀번호 확인
                    TextFormField(
                      controller: _checkPasswordController,
                      maxLines: 1,
                      cursorColor: authFormLightBlueColor,
                      validator: (text) {
                        if (text == null || text.isEmpty) {
                          return Strings.emptyTextForm;
                        }
                        if (_passwordController.text != text) {
                          return Strings.invalidCPasswordForm;
                        }
                        return null;
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
                          "비밀번호 확인",
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
                    // 약관 동의
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 18,
                          height: 30,
                          child: Checkbox(
                            value: _agreeTerms,
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
                                _agreeTerms = !_agreeTerms;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "약관에 동의합니다.",
                            style: Theme.of(context)
                                .textTheme
                                .labelLarge!
                                .copyWith(
                                  color: authFormNavyBlueColor,
                                  fontWeight: FontWeight.w600,
                                ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                setState(() {
                                  _agreeTerms = !_agreeTerms;
                                });
                              },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    // 회원가입
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (widget.register != null) {
                            UserCreateData newRegister = UserCreateData(
                              name: _idController.text,
                              email: _emailController.text,
                              password: _passwordController.text,
                            );
                            widget.register!(newRegister);
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
                        "회원가입",
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: authFormCreamWhiteColor),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '계정이 이미 있으신가요?  ',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: authFormTextColor,
                          fontWeight: FontWeight.w700),
                    ),
                    TextSpan(
                      text: '로그인하기',
                      style: Theme.of(context).textTheme.labelLarge!.copyWith(
                          color: authFormLightBlueColor,
                          fontWeight: FontWeight.w700),
                      recognizer: TapGestureRecognizer()
                        ..onTap = widget.changeToLogin,
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
