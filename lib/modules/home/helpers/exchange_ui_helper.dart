import 'package:flutter/material.dart';

import '../../../core/models/currency_option.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/currency_selector_sheet.dart';

class ExchangeUIHelper {
  static Future<CurrencyOption?> showCurrencySelector({
    required BuildContext context,
    required List<CurrencyOption> options,
    required String title,
    String? activeId,
  }) async {
    return showModalBottomSheet<CurrencyOption>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      builder: (BuildContext context) {
        return CurrencySelectorSheet(
          options: options,
          activeId: activeId,
          title: title,
          onSelected: (CurrencyOption option) {
            Navigator.of(context).pop(option);
          },
        );
      },
    );
  }
}

