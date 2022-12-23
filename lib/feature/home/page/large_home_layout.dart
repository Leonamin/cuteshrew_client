import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/feature/home/page/home_screen.dart';
import 'package:flutter/material.dart';

class LargeHomeLayout extends StatelessWidget {
  const LargeHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            color: lightGrey,
          ),
        ),
        Expanded(
            flex: 4,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: HomeScreen())),
        Expanded(
          flex: 1,
          child: Container(
            color: lightGrey,
          ),
        ),
      ],
    );
  }
}
