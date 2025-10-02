import '../../../core/models/currency_option.dart';
import '../../../core/models/exchange_recommendation.dart';

/// Immutable state of the exchange.
class ExchangeState {
  const ExchangeState({
    required this.from,
    required this.to,
    this.amount = '',
    this.isExecuting = false,
    this.recommendation,
    this.error,
  });

  final CurrencyOption? from;
  final CurrencyOption? to;
  final String amount;
  final bool isExecuting;
  final ExchangeRecommendationSummary? recommendation;
  final String? error;

  double get amountValue => double.tryParse(amount) ?? 0.0;

  bool get hasError => error != null;
  bool get hasRecommendation => recommendation != null;
  bool get canExecute => amount.isNotEmpty && from != null && to != null && !isExecuting;

  ExchangeState copyWith({
    CurrencyOption? from,
    CurrencyOption? to,
    String? amount,
    bool? isExecuting,
    ExchangeRecommendationSummary? recommendation,
    String? error,
    bool clearRecommendation = false,
    bool clearError = false,
  }) {
    return ExchangeState(
      from: from ?? this.from,
      to: to ?? this.to,
      amount: amount ?? this.amount,
      isExecuting: isExecuting ?? this.isExecuting,
      recommendation: clearRecommendation ? null : (recommendation ?? this.recommendation),
      error: clearError ? null : (error ?? this.error),
    );
  }

  ExchangeState clearRecommendation() {
    return copyWith(clearRecommendation: true, clearError: true);
  }
}

