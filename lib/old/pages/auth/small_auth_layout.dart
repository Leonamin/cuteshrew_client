import 'package:cuteshrew/old/pages/auth/auth_screen.dart';
import 'package:flutter/material.dart';

class SmallAuthLayout extends StatelessWidget {
  const SmallAuthLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: AuthScreen());
  }
}
