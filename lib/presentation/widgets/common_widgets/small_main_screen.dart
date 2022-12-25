import 'package:flutter/material.dart';

class SmallMainScreen extends StatelessWidget {
  final Widget? child;
  const SmallMainScreen({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
