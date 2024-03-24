import 'package:cuteshrew/0_foundation/ui/color_palettes.dart';
import 'package:flutter/material.dart';

class CircleProfileWidget extends StatelessWidget {
  final String? thumbUrl;
  final double size;

  static const tiny = 24.0;
  static const small = 32.0;
  static const medium = 40.0;
  static const large = 48.0;

  const CircleProfileWidget({
    super.key,
    this.thumbUrl,
    this.size = medium,
  });

  bool get hasThumbUrl => thumbUrl != null && thumbUrl!.isNotEmpty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: ColorPaletts.grayscale2,
      ),
      child: hasThumbUrl
          ? ClipOval(
              child: Image.network(
                thumbUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              ),
            )
          : Icon(
              Icons.person,
              size: size * 0.8,
            ),
    );
  }
}
