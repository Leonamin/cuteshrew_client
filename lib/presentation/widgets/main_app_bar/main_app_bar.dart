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
      leading: //!ResponsiveWidget.isSmallScreen(context)
          true
              ? Row(
                  children: [
                    InkWell(
                      child: Container(
                        padding: EdgeInsets.only(left: 4),
                        child: Image.asset(
                          "assets/icons/logo.png",
                          width: 50,
                        ),
                      ),
                      onTap: () {
                        locator<NavigationService>()
                            .navigateTo(Routes.HomePageRoute);
                      },
                    ),
                  ],
                )
              : IconButton(
                  onPressed: () {
                    key.currentState!.openDrawer();
                  },
                  icon: const Icon(Icons.menu)),
      elevation: 0.0,
      title: const MainNavTitle(),
      iconTheme: const IconThemeData(color: dark),
      backgroundColor: lightCream,
    );

class MainNavTitle extends StatelessWidget {
  const MainNavTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthenticationState>(builder: (context, state, child) {
      return Row(
        children: [
          // 이거 왜 있었는지 까먹음 사이트 제목 쓰는곳이었나?
          // Visibility(
          //     child: CustomText(
          //   text: "",
          //   color: lightGrey,
          //   size: 20,
          //   weight: FontWeight.bold,
          // )),
          Expanded(child: Container()),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.shuffle_rounded,
                color: dark.withOpacity(.7),
              )),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.notifications),
                color: dark.withOpacity(.7),
              ),
              Positioned(
                  top: 7,
                  right: 7,
                  child: Container(
                    width: 12,
                    height: 12,
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: active,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: light, width: 2)),
                  ))
            ],
          ),
          Container(
            width: 1,
            height: 22,
            color: lightGrey,
          ),
          const SizedBox(
            width: 24,
          ),
          InkWell(
            onTap: () {
              state is UnauthorizedState
                  ? locator<NavigationService>()
                      .navigateTo(Routes.LoginPageRoute)
                  : context.read<AuthenticationProvider>().logout();
            },
            child: CustomText(
              text: state is UnauthorizedState ? Strings.login : Strings.logout,
              color: lightGrey,
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Container(
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(30)),
            child: Container(
                padding: const EdgeInsets.all(2),
                margin: const EdgeInsets.all(2),
                child: CircleAvatar(
                  backgroundColor: light,
                  child: state is AuthorizedState
                      ? const Icon(
                          Icons.person_outline,
                          color: dark,
                        )
                      : const Icon(
                          Icons.person_outline,
                          color: light,
                        ),
                )),
          )
        ],
      );
    });
  }
}
