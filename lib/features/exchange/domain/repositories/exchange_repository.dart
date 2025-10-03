import '../../../../core/models/currency_option.dart';
import '../../../../core/utils/result.dart';
import '../entities/exchange_rate_entity.dart';

/// contract that must be fulfilled by the implementation in the data layer
abstract class ExchangeRepository {
  Future<Result<ExchangeRateEntity>> getExchangeRate({
    required CurrencyOption from,
    required CurrencyOption to,
    required String amount,
  });
}

