import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ChipLabel extends StatelessWidget {
  const ChipLabel({required this.text, super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: AppColors.cardBackground,
      child: Text(text, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500)),
    );
  }
}
