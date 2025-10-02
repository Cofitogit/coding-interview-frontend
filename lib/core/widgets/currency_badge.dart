import 'package:flutter/material.dart';

import '../models/currency_option.dart';
import '../theme/app_theme.dart';

class CurrencyBadge extends StatelessWidget {
  const CurrencyBadge({
    required this.option,
    this.size = 24,
    super.key,
  });

  final CurrencyOption option;
  final double size;

  @override
  Widget build(BuildContext context) {
    if (option.hasAsset) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(6),
        child: Image.asset(
          option.assetPath!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    final String initials = option.code.length >= 2
        ? option.code.substring(0, 2)
        : option.code;
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        color: AppColors.surface,
        width: size,
        height: size,
        child: Center(
          child: Text(
            initials.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w600,
              fontSize: size * 0.45,
            ),
          ),
        ),
      ),
    );
  }
}
