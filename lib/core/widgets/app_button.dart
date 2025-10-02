import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../theme/app_theme.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onPressed,
    this.enabled = true,
    this.isLoading = false,
    super.key,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool enabled;
  final bool isLoading;

  bool get _canTap => enabled && !isLoading && onPressed != null;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : 0.6,
      child: ElevatedButton(
        onPressed: _canTap ? onPressed : null,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: AnimatedSwitcher(
          duration: AppTheme.homeContentDuration,
          child: isLoading
              ? LoadingAnimationWidget.stretchedDots(color: AppColors.cardBackground, size: 20)
              : Text(
                  label,
                  key: const ValueKey<String>('label'),
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
        ),
      ),
    );
  }
}
