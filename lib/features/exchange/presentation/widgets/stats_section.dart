import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/exchange_state.dart';
import '../viewmodels/exchange_vm.dart';
import 'info_row.dart';

class StatsSection extends ConsumerWidget {
  const StatsSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ExchangeState state = ref.watch(exchangeViewModelProvider);
    final String? toCurrency = state.toCurrency?.code;
    final bool hasData = state.hasRecommendation;

    // Usar computed properties del state
    final String estimatedRate = state.formattedRate;
    final double receiveAmount = state.receiveAmount;
    final String estimatedTime = state.formattedEstimatedTime;

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
                    value: estimatedRate,
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
