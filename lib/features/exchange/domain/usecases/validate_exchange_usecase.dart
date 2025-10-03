import '../../../../core/utils/result.dart';
import '../entities/exchange_rate_entity.dart';

class ValidateExchangeUseCase {
  const ValidateExchangeUseCase();

  Result<void> call({
    required double amount,
    required ExchangeRateEntity exchangeRate,
    required String currencyCode,
  }) {
    if (!exchangeRate.isAmountValid(amount)) {
      if (exchangeRate.minLimit != null && amount < exchangeRate.minLimit!) {
        return Failure<void>(
          'Monto mínimo: ${exchangeRate.minLimit!.toStringAsFixed(2)} $currencyCode',
        );
      }

      if (exchangeRate.maxLimit != null && amount > exchangeRate.maxLimit!) {
        return Failure<void>(
          'Monto máximo: ${exchangeRate.maxLimit!.toStringAsFixed(2)} $currencyCode',
        );
      }
    }

    return const Success<void>(null);
  }
}

