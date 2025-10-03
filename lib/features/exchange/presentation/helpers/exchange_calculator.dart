import '../../../../core/models/currency_option.dart';
import '../../../../core/models/exchange_recommendation.dart';

class ExchangeCalculator {
  static double calculateReceiveAmount({
    required ExchangeRecommendationSummary? recommendation,
    required double amount,
    required bool isCryptoToFiat,
  }) {
    if (recommendation == null || amount == 0) {
      return 0.0;
    }

    return recommendation.calculateReceiveAmount(
      amount: amount,
      isCryptoToFiat: isCryptoToFiat,
    );
  }

  static double getEstimatedRate(ExchangeRecommendationSummary? recommendation) {
    return recommendation?.fiatToCryptoRate ?? 0.0;
  }

  static String formatEstimatedTime({
    ExchangeRecommendationSummary? recommendation,
    int decimals = 1,
  }) {
    return recommendation?.formatEstimatedMinutes(decimals: decimals) ?? '--';
  }

  static double? getMinLimit({
    required ExchangeRecommendationSummary? recommendation,
    required bool isCryptoToFiat,
  }) {
    final CurrencyLimits? limits = recommendation?.limitsForExchange(
      isCryptoToFiat: isCryptoToFiat,
    );
    return limits?.minLimit;
  }

  static double? getMaxLimit({
    required ExchangeRecommendationSummary? recommendation,
    required bool isCryptoToFiat,
  }) {
    final CurrencyLimits? limits = recommendation?.limitsForExchange(
      isCryptoToFiat: isCryptoToFiat,
    );
    return limits?.maxLimit;
  }

  static int determineExchangeType({
    required CurrencyOption? from,
    required CurrencyOption? to,
  }) {
    if (from == null || to == null) {
      return 0;
    }
    if (from.kind == CurrencyKind.crypto && to.kind == CurrencyKind.fiat) {
      return 0;
    }
    return 1;
  }
}

