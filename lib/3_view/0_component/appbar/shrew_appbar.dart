import 'package:flutter/material.dart';

class ShrewAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double? toolbarHeight;
  final Widget? leading;
  final List<Widget> actions;
  final Widget? title;

  const ShrewAppBar({
    super.key,
    this.toolbarHeight,
    this.leading,
    this.actions = const [],
    this.title,
  });

  factory ShrewAppBar.title({
    double? toolbarHeight,
    Widget? leading,
    List<Widget> actions = const [],
    required String title,
  }) {
    return ShrewAppBar(
      toolbarHeight: toolbarHeight,
      leading: leading,
      actions: actions,
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      actions: actions,
      title: title,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight ?? kToolbarHeight);
}
