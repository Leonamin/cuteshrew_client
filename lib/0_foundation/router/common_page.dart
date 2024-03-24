import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonPage {
  const CommonPage({required this.child});

  final Widget child;

  Page noTransition() {
    return NoTransitionPage(
      child: child,
    );
  }
}
