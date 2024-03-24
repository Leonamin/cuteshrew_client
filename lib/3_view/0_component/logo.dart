import 'package:cuteshrew/0_foundation/asset/asset_image_icon.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      AssetImageIcon.logo.path,
    );
  }
}
