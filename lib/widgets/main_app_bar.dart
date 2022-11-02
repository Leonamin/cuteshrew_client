import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/providers/login_notifier.dart';
import 'package:cuteshrew/pages/auth/auth_page.dart';
import 'package:cuteshrew/pages/home/home_page.dart';
import 'package:cuteshrew/states/login_state.dart';
import 'package:cuteshrew/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuteshrew/strings/strings.dart';

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
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ));
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
    return Consumer<LoginState>(builder: (context, state, child) {
      return Row(
        children: [
          Visibility(
              child: CustomText(
            text: "",
            color: lightGrey,
            size: 20,
            weight: FontWeight.bold,
          )),
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
                  ? Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthPage(),
                      ))
                  : context.read<LoginNotifier>().logout();
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
