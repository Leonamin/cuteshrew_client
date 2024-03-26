import 'package:avatar_glow/avatar_glow.dart';
import 'package:cuteshrew/0_foundation/asset/asset_image_icon.dart';
import 'package:cuteshrew/0_foundation/ui/color_palettes.dart';
import 'package:flutter/material.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: AvatarGlow(
          glowColor: ColorPaletts.primary1,
          duration: const Duration(milliseconds: 1000),
          child: Image.asset(
            AssetImageIcon.logo.path,
            height: 50,
          ),
        ),
      ),
    );
  }
}
