import 'package:cuteshrew/presentation/screens/auth/widgets/login_widget_form_panel.dart';
import 'package:cuteshrew/presentation/screens/auth/widgets/login_widget_info_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';

class ExpandedLoginWidget extends StatefulWidget {
  const ExpandedLoginWidget({super.key});

  @override
  State<ExpandedLoginWidget> createState() => _ExpandedLoginWidgetState();
}

class _ExpandedLoginWidgetState extends State<ExpandedLoginWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Container(
          height: 640,
          width: 1080,
          margin: const EdgeInsets.symmetric(horizontal: 24),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(32),
            color: Colors.grey,
          ),
          child: Row(
            children: [
              const Expanded(
                flex: 1,
                child: LoginWidgetFormPanel(),
              ),
              Expanded(
                flex: 1,
                child: LoginWidgetInfoPanel(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
