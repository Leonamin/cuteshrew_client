import 'package:cuteshrew/constants/style.dart';
import 'package:flutter/material.dart';

class CircleUserIcon extends StatelessWidget {
  Widget? child;
  Color? backgroundColor;

  CircleUserIcon({super.key, this.child, this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Container(
          padding: const EdgeInsets.all(2),
          margin: const EdgeInsets.all(2),
          child: CircleAvatar(
            backgroundColor: backgroundColor ?? light,
            child: child,
          )),
    );
  }
}
