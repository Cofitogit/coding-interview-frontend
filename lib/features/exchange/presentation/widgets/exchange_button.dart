import 'package:flutter/material.dart';

import '../../../../core/widgets/app_button.dart';

class ExchangeButton extends StatelessWidget {
  const ExchangeButton({
    super.key,
    this.enabled = true,
    this.isLoading = false,
    this.onPressed,
  });

  final bool enabled;
  final bool isLoading;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: AppButton(
            label: 'Cambiar',
            enabled: enabled,
            isLoading: isLoading,
            onPressed: onPressed,
          ),
        ),
      ],
    );
  }
}
