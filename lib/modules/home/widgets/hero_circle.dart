import 'package:flutter/material.dart';

import '../../../core/theme/app_theme.dart';

class HeroCircle extends StatelessWidget {
  const HeroCircle({required this.size, super.key});

  final double size;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppTheme.homeHeroDuration,
      curve: Curves.easeInOut,
      width: size,
      height: size,
      decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(size / 2)),
    );
  }
}
