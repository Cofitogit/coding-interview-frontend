import '../../../../core/models/currency_option.dart';
import '../../../../core/models/exchange_recommendation.dart';

class ExchangeValidationResult {
  const ExchangeValidationResult({
    this.error,
    this.isValid = true,
  });

  factory ExchangeValidationResult.failure(String error) {
    return ExchangeValidationResult(error: error, isValid: false);
  }

  factory ExchangeValidationResult.success() {
    return const ExchangeValidationResult();
  }

  final String? error;
  final bool isValid;
}

/// Validador de operaciones de exchange.
class ExchangeValidator {
  /// Valida que el monto esté dentro de los límites permitidos.
  static ExchangeValidationResult validateAmount({
    required double amount,
    required ExchangeRecommendationSummary? recommendation,
    required bool isCryptoToFiat,
    required CurrencyOption? fromCurrency,
  }) {
    if (recommendation == null) {
      return ExchangeValidationResult.failure('No hay recomendaciones disponibles');
    }

    if (!recommendation.primaryOffer.hasValidRate) {
      return ExchangeValidationResult.failure('No hay ofertas disponibles para esta operación');
    }

    final CurrencyLimits? limits = recommendation.limitsForExchange(
      isCryptoToFiat: isCryptoToFiat,
    );

    if (limits == null) {
      return ExchangeValidationResult.success();
    }

    final String currency = fromCurrency?.code ?? '';

    if (amount < limits.minLimit) {
      return ExchangeValidationResult.failure(
        'Monto mínimo: ${limits.minLimit.toStringAsFixed(2)} $currency',
      );
    }

    if (amount > limits.maxLimit) {
      return ExchangeValidationResult.failure(
        'Monto máximo: ${limits.maxLimit.toStringAsFixed(2)} $currency',
      );
    }

    return ExchangeValidationResult.success();
  }
}

