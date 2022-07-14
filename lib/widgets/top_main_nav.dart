import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/helpers/responsiveness.dart';
import 'package:cuteshrew/provider/login_provider.dart';
import 'package:cuteshrew/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cuteshrew/strings/strings.dart';

AppBar topMainNavigationBar(
        BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.isSmallScreen(context)
          ? Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 4),
                  child: Image.asset(
                    "assets/icons/logo.png",
                    width: 50,
                  ),
                ),
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState!.openDrawer();
              },
              icon: const Icon(Icons.menu)),
      elevation: 0.0,
      title: Row(
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
            onTap: () {},
            child: CustomText(
              text: context.read<LoginProvider>().userNickname ?? Strings.login,
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
                  child: (context.read<LoginProvider>().status ==
                          Status.Authenticated)
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
      iconTheme: IconThemeData(color: dark),
      backgroundColor: lightCream,
    );
