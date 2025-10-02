import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/exchange_provider.dart';
import 'info_row.dart';

class StatsSection extends StatelessWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final ExchangeProvider exchange = context.watch<ExchangeProvider>();
    final String? toCurrency = exchange.to?.code;
    final bool hasData = exchange.recommendation != null;

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
                      value: exchange.estimatedRate.toStringAsFixed(2),
                      suffix: toCurrency ?? '',
                    ),
                    InfoRow(
                      label: 'Recibirás',
                      value: exchange.receiveAmount.toStringAsFixed(2),
                      suffix: toCurrency ?? '',
                    ),
                    InfoRow(
                      label: 'Tiempo estimado',
                      value: exchange.estimatedTimeFormatted,
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
