import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/models/currency_option.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/usecases/get_exchange_rate_usecase.dart';
import '../../domain/usecases/validate_exchange_usecase.dart';
import '../state/exchange_state.dart';
import 'currency_options_provider.dart';
import 'exchange_dependencies.dart';

part 'exchange_vm.g.dart';

@riverpod
class ExchangeViewModel extends _$ExchangeViewModel {
  @override
  ExchangeState build() {
    final CurrencyOptions options = ref.read(currencyOptionsProvider);

    //! Initial state
    return ExchangeState(fromCurrency: options.crypto.first, toCurrency: options.fiat.first);
  }

  // ==================== Actions ====================

  /// Selects the origin currency
  void selectFrom(CurrencyOption option) {
    state = state.copyWith(fromCurrency: option, errorMessage: null, recommendation: null);
  }

  /// Selects the destination currency
  void selectTo(CurrencyOption option) {
    state = state.copyWith(toCurrency: option, errorMessage: null, recommendation: null);
  }

  /// Swaps the currencies (from <-> to)
  void swap() {
    state = state.copyWith(
      fromCurrency: state.toCurrency,
      toCurrency: state.fromCurrency,
      errorMessage: null,
      recommendation: null,
    );
  }

  /// Updates the amount entered
  void updateAmount(String value) {
    state = state.copyWith(amount: value, errorMessage: null, recommendation: null);
  }

  /// Executes the exchange rate calculation
  Future<void> execute() async {
    if (!state.canExecute) {
      return;
    }

    //! Show loading
    state = state.copyWith(isLoading: true, errorMessage: null);

    final GetExchangeRateUseCase getExchangeRate = ref.read(getExchangeRateUseCaseProvider);
    final ValidateExchangeUseCase validateExchange = ref.read(validateExchangeUseCaseProvider);

    final Result<ExchangeRateEntity> result = await getExchangeRate(
      from: state.fromCurrency!,
      to: state.toCurrency!,
      amount: state.amount,
    );

    result.fold(
      onSuccess: (ExchangeRateEntity entity) {
        validateExchange(amount: state.amountValue, exchangeRate: entity, currencyCode: state.fromCurrency!.code).fold(
          onSuccess: (_) {
            state = state.copyWith(isLoading: false, recommendation: entity, errorMessage: null);
          },
          onFailure: (String error) {
            state = state.copyWith(isLoading: false, recommendation: entity, errorMessage: error);
          },
        );
      },
      onFailure: (String error) {
        state = state.copyWith(isLoading: false, errorMessage: error, recommendation: null);
      },
    );
  }
}
