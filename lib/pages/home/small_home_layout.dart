import 'package:cuteshrew/pages/home/home_screen.dart';
import 'package:flutter/material.dart';

class SmallHomeLayout extends StatelessWidget {
  const SmallHomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: HomeScreen());
  }
}
