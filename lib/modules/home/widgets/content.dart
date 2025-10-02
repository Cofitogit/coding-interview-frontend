import 'package:flutter/material.dart';

import '../../../core/models/currency_option.dart';
import '../../../core/theme/app_theme.dart';
import '../helpers/_index.dart';
import '../providers/_index.dart';
import '_index.dart';

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
                    onSelectFrom: () => _handleSelectCurrency(context, exchangeProvider, isFrom: true),
                    onSelectTo: () => _handleSelectCurrency(context, exchangeProvider, isFrom: false),
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

  Future<void> _handleSelectCurrency(
    BuildContext context,
    ExchangeProvider provider, {
    required bool isFrom,
  }) async {
    final CurrencyOption? current = isFrom ? provider.from : provider.to;
    final CurrencyKind kind = current?.kind ?? (isFrom ? CurrencyKind.crypto : CurrencyKind.fiat);
    final List<CurrencyOption> options =
        kind == CurrencyKind.crypto ? ExchangeProvider.cryptoOptions : ExchangeProvider.fiatOptions;

    final CurrencyOption? selected = await ExchangeUIHelper.showCurrencySelector(
      context: context,
      options: options,
      title: kind == CurrencyKind.crypto ? 'Cripto' : 'Fiat',
      activeId: current?.id,
    );

    if (selected != null) {
      if (isFrom) {
        provider.selectFrom(selected);
      } else {
        provider.selectTo(selected);
      }
    }
  }
}
