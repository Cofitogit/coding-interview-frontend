import 'package:flutter/material.dart';

import '../../../../core/models/currency_option.dart';
import '../../../../core/theme/app_theme.dart';
import 'amount_field.dart';
import 'error_message_card.dart';
import 'exchange_button.dart';
import 'exchange_selector.dart';
import 'stats_section.dart';

class ExchangeCard extends StatelessWidget {
  const ExchangeCard({
    required this.from,
    required this.to,
    required this.onSelectFrom,
    required this.onSelectTo,
    required this.onAmountChanged,
    required this.amount,
    this.onExchange,
    this.onSwap,
    this.isExchangeEnabled = true,
    this.isExchangeLoading = false,
    this.error,
    super.key,
  });

  final CurrencyOption from;
  final CurrencyOption to;
  final VoidCallback onSelectFrom;
  final VoidCallback onSelectTo;
  final ValueChanged<String> onAmountChanged;
  final String amount;
  final VoidCallback? onExchange;
  final VoidCallback? onSwap;
  final bool isExchangeEnabled;
  final bool isExchangeLoading;
  final String? error;

  @override
  Widget build(BuildContext context) {
    // ignore: use_decorated_box
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: const BorderRadius.all(Radius.circular(24)),
        border: Border.all(width: 2, color: AppColors.border),
        boxShadow: const <BoxShadow>[
          BoxShadow(blurRadius: 3, spreadRadius: 0, color: AppColors.shadow, offset: Offset(0, 4)),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: <Widget>[
            ExchangeSelector(
              from: from,
              to: to,
              onSelectFrom: onSelectFrom,
              onSelectTo: onSelectTo,
              onSwap: onSwap,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 8,
              children: <Widget>[
                AmountField(currencyLabel: from.code, amount: amount, onChanged: onAmountChanged),
                if (error != null)
                  ErrorMessageCard(
                    message: error!,
                    onRetry: isExchangeEnabled && !isExchangeLoading ? onExchange : null,
                  ),
              ],
            ),
            const StatsSection(),
            ExchangeButton(onPressed: onExchange, enabled: isExchangeEnabled, isLoading: isExchangeLoading),
          ],
        ),
      ),
    );
  }
}
