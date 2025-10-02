import '../../../core/models/currency_option.dart';
import '../../../core/models/exchange_recommendation.dart';

/// Calculadora de valores para operaciones de exchange.
class ExchangeCalculator {
  /// Calcula el monto a recibir en base a la operación.
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

  /// Obtiene la tasa de cambio fiat -> crypto.
  static double getEstimatedRate(ExchangeRecommendationSummary? recommendation) {
    return recommendation?.fiatToCryptoRate ?? 0.0;
  }

  /// Formatea el tiempo estimado para la UI.
  static String formatEstimatedTime({
    ExchangeRecommendationSummary? recommendation,
    int decimals = 1,
  }) {
    return recommendation?.formatEstimatedMinutes(decimals: decimals) ?? '--';
  }

  /// Obtiene el límite mínimo para la operación actual.
  static double? getMinLimit({
    required ExchangeRecommendationSummary? recommendation,
    required bool isCryptoToFiat,
  }) {
    final CurrencyLimits? limits = recommendation?.limitsForExchange(
      isCryptoToFiat: isCryptoToFiat,
    );
    return limits?.minLimit;
  }

  /// Obtiene el límite máximo para la operación actual.
  static double? getMaxLimit({
    required ExchangeRecommendationSummary? recommendation,
    required bool isCryptoToFiat,
  }) {
    final CurrencyLimits? limits = recommendation?.limitsForExchange(
      isCryptoToFiat: isCryptoToFiat,
    );
    return limits?.maxLimit;
  }

  /// Determina el tipo de exchange (0: crypto->fiat, 1: fiat->crypto).
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

