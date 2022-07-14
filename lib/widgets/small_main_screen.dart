import 'package:cuteshrew/helpers/local_navigator.dart';
import 'package:flutter/material.dart';

class SmallMainScreen extends StatelessWidget {
  const SmallMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: localNavigator());
  }
}
