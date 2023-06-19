import 'package:cuteshrew/config/constants/style.dart';
import 'package:flutter/material.dart';

class LargeMainScreen extends StatelessWidget {
  final Widget? child;
  const LargeMainScreen({Key? key, this.child}) : super(key: key);

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
              child: child,
            )),
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
