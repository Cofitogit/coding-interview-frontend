import 'package:flutter/material.dart';

import '../../../core/models/currency_option.dart';
import '../../../core/theme/app_theme.dart';
import '../providers/exchange_provider.dart';
import 'exchange_card.dart';

class Content extends StatelessWidget {
  const Content({required this.visible, required this.exchangeProvider, super.key});

  final bool visible;
  final ExchangeProvider exchangeProvider;

  @override
  Widget build(BuildContext context) {
    final CurrencyOption? from = exchangeProvider.from;
    final CurrencyOption? to = exchangeProvider.to;

    return AnimatedSwitcher(
      duration: AppTheme.homeContentDuration,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
            child: child,
          ),
        );
      },
      child: visible && from != null && to != null
          ? Padding(
              key: const ValueKey<String>('home-content'),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 16,
                children: <Widget>[
                  ExchangeCard(
                    from: from,
                    to: to,
                    onSelectFrom: () => exchangeProvider.openSelector(context, isFrom: true),
                    onSelectTo: () => exchangeProvider.openSelector(context, isFrom: false),
                    onSwap: exchangeProvider.swap,
                    amount: exchangeProvider.amount,
                    onAmountChanged: exchangeProvider.updateAmount,
                    onExchange: exchangeProvider.execute,
                    isExchangeEnabled: exchangeProvider.amount.isNotEmpty,
                    isExchangeLoading: exchangeProvider.isExecuting,
                    error: exchangeProvider.error,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink(key: ValueKey<String>('home-content-hidden')),
    );
  }
}
