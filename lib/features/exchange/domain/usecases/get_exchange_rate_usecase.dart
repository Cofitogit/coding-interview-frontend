import '../../../../core/errors/failures.dart';
import '../../../../core/models/currency_option.dart';
import '../../../../core/utils/result.dart';
import '../entities/exchange_rate_entity.dart';
import '../repositories/exchange_repository.dart';

class GetExchangeRateUseCase {
  const GetExchangeRateUseCase(this._repository);

  final ExchangeRepository _repository;

  Future<Result<ExchangeRateEntity>> call({
    required CurrencyOption from,
    required CurrencyOption to,
    required String amount,
  }  ) async {
    if (amount.isEmpty) {
      return const Failure<ExchangeRateEntity>(
        ValidationFailure('El monto no puede estar vacío'),
      );
    }

    final double? amountValue = double.tryParse(amount);
    if (amountValue == null) {
      return const Failure<ExchangeRateEntity>(
        ValidationFailure('El monto debe ser un número válido'),
      );
    }

    if (amountValue <= 0) {
      return const Failure<ExchangeRateEntity>(
        ValidationFailure('El monto debe ser mayor a 0'),
      );
    }

    if (from.id == to.id) {
      return const Failure<ExchangeRateEntity>(
        ValidationFailure('Las monedas deben ser diferentes'),
      );
    }

    return _repository.getExchangeRate(
      from: from,
      to: to,
      amount: amount,
    );
  }
}

