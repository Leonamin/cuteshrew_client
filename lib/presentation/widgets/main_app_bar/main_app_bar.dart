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
    return Consumer<AuthenticationState>(builder: (context, state, child) {
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
              /*
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.shuffle_rounded,
                    color: Theme.of(context).colorScheme.primary,
                  )),
              Stack(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.notifications),
                    color: Theme.of(context).colorScheme.primary,
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
              */
              InkWell(
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
              const SizedBox(
                width: 16,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30)),
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
          ),
        ],
      );
    });
  }
}
