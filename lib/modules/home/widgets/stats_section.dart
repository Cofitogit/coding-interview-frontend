import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../helpers/_index.dart';
import '../models/_index.dart';
import '../providers/_index.dart';
import '_index.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeProvider exchange = context.watch<ExchangeProvider>();
    final ExchangeState state = exchange.exchangeState;
    final String? toCurrency = state.to?.code;
    final bool hasData = state.hasRecommendation;

    // Calcular valores usando los helpers
    final int exchangeType = ExchangeCalculator.determineExchangeType(
      from: state.from,
      to: state.to,
    );
    final double estimatedRate = ExchangeCalculator.getEstimatedRate(state.recommendation);
    final double receiveAmount = ExchangeCalculator.calculateReceiveAmount(
      recommendation: state.recommendation,
      amount: state.amountValue,
      isCryptoToFiat: exchangeType == 0,
    );
    final String estimatedTime = ExchangeCalculator.formatEstimatedTime(
      recommendation: state.recommendation,
      decimals: 1,
    );

    return AnimatedSize(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 250),
        opacity: hasData ? 1.0 : 0.0,
        child: hasData
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  spacing: 16,
                  children: <Widget>[
                    InfoRow(
                      label: 'Tasa estimada',
                      value: estimatedRate.toStringAsFixed(2),
                      suffix: toCurrency ?? '',
                    ),
                    InfoRow(
                      label: 'Recibirás',
                      value: receiveAmount.toStringAsFixed(2),
                      suffix: toCurrency ?? '',
                    ),
                    InfoRow(
                      label: 'Tiempo estimado',
                      value: estimatedTime,
                      suffix: 'Min',
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ),
    );
  }
}
