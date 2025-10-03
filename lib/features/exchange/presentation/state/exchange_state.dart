import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../core/models/currency_option.dart';
import '../../../exchange/domain/entities/exchange_rate_entity.dart';

part 'exchange_state.freezed.dart';

@freezed
class ExchangeState with _$ExchangeState {
  const factory ExchangeState({
    required CurrencyOption? fromCurrency,
    required CurrencyOption? toCurrency,
    @Default('') String amount,
    @Default(false) bool isLoading,
    ExchangeRateEntity? recommendation,
    String? errorMessage,
  }) = _ExchangeState;
}

// ==================== Computed Properties ====================

extension ExchangeStateX on ExchangeState {
  /// Monto parseado a double
  double get amountValue => double.tryParse(amount) ?? 0.0;

  /// Indica si hay un error
  bool get hasError => errorMessage != null;

  /// Indica si hay datos de recomendación
  bool get hasRecommendation => recommendation != null;

  /// Indica si se puede ejecutar el cálculo
  bool get canExecute =>
      amount.isNotEmpty &&
      fromCurrency != null &&
      toCurrency != null &&
      !isLoading &&
      amountValue > 0;

  /// Tipo de exchange (0: crypto->fiat, 1: fiat->crypto)
  int get exchangeType {
    if (fromCurrency == null || toCurrency == null) {
      return 0;
    }
    return fromCurrency!.kind == CurrencyKind.crypto &&
            toCurrency!.kind == CurrencyKind.fiat
        ? 0
        : 1;
  }

  /// Es crypto a fiat
  bool get isCryptoToFiat => exchangeType == 0;

  /// Monto que recibirá el usuario
  double get receiveAmount {
    if (recommendation == null || amountValue == 0) {
      return 0.0;
    }
    return recommendation!.calculateReceiveAmount(
      amount: amountValue,
      isCryptoToFiat: isCryptoToFiat,
    );
  }

  /// Tasa estimada formateada
  String get formattedRate {
    if (recommendation == null) {
      return '--';
    }
    return recommendation!.rate.toStringAsFixed(2);
  }

  /// Tiempo estimado formateado
  String get formattedEstimatedTime {
    if (recommendation == null) {
      return '--';
    }
    return recommendation!.formatEstimatedMinutes();
  }
}
