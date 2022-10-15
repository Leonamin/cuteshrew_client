import 'package:cuteshrew/constants/style.dart';
import 'package:cuteshrew/pages/home/home_widget.dart';
import 'package:flutter/material.dart';

class SmallHomeScreen extends StatelessWidget {
  const SmallHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: HomeWidget());
  }
}
