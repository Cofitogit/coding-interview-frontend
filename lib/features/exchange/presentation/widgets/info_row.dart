import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({required this.label, required this.value, required this.suffix, super.key});

  final String label;
  final String value;
  final String suffix;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8,
      children: <Widget>[
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.w500, color: AppColors.textDark),
        ),
        const Spacer(),
        const Text('≈'),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        Text(suffix, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
      ],
    );
  }
}
