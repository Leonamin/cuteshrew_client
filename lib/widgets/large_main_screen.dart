import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/helpers/local_navigator.dart';
import 'package:flutter/material.dart';

class LargeMainScreen extends StatelessWidget {
  const LargeMainScreen({Key? key}) : super(key: key);

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
                child: localNavigator())),
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
