import 'package:cuteshrew/di/navigation_service.dart';
import 'package:cuteshrew/di/service_locator.dart';
import 'package:cuteshrew/presentation/config/route/routes.dart';
import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_provider.dart';
import 'package:cuteshrew/presentation/providers/authentication/authentication_state.dart';
import 'package:cuteshrew/presentation/strings/strings.dart';
import 'package:cuteshrew/presentation/widgets/common_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

AppBar mainAppBar(BuildContext context, GlobalKey<ScaffoldState> key) => AppBar(
      elevation: 0.0,
      title: const MainNavTitle(),
      iconTheme: const IconThemeData(color: dark),
      backgroundColor: Theme.of(context).colorScheme.onPrimary,
    );

class MainNavTitle extends StatelessWidget {
  const MainNavTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: GestureDetector(
            onTap: () {
              locator<NavigationService>().navigateTo(Routes.HomePageRoute);
            },
            child: Text(
              "귀여운 땃쥐",
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
        Row(
          children: [
            Consumer<AuthenticationState>(
              builder: (context, state, child) => InkWell(
                onTap: () {
                  state is UnauthorizedState
                      ? locator<NavigationService>()
                          .navigateTo(Routes.LoginPageRoute)
                      : context.read<AuthenticationProvider>().logout();
                },
                child: CustomText(
                  text: state is UnauthorizedState
                      ? Strings.login
                      : Strings.logout,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            // TODO 유저 정보를 받게되면 프로필 그때 바꾸자
            // 로그인 토큰 -> 토큰 업데이트 -> 유저 미리보기 정보 가져오기
            // 근데 이게 맞나>?
            // Authorized에 UserPreview를 포함하거나
            // UserPreview를 가지는 단독 프로바이더를 또 만들어야할텐데
            // AuthorizedProvider에서 UserInfoProvider로 접근할 방법이 안떠오르고

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: const CircleAvatar(
                  backgroundColor: light,
                  child: Icon(
                    Icons.person_outline,
                    color: light,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
