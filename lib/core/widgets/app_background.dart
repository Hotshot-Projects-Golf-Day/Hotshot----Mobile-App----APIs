import 'package:flutter/material.dart';
import 'package:upd8s/core/constants/app_images.dart';

class AppBackground extends StatelessWidget {
  final Widget child;

  const AppBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(AppAssets.bg, fit: BoxFit.cover),

        child,
      ],
    );
  }
}
