import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/pages/home/home_widget.dart';
import 'package:flutter/material.dart';

class LargeHomeScreen extends StatelessWidget {
  const LargeHomeScreen({Key? key}) : super(key: key);

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
                child: HomeWidget())),
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
