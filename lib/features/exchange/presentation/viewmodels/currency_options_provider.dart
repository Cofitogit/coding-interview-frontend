import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/models/currency_catalog.dart';
import '../../../../core/models/currency_option.dart';

part 'currency_options_provider.g.dart';

/// Available currencies
class CurrencyOptions {
  const CurrencyOptions({
    required this.crypto,
    required this.fiat,
  });

  final List<CurrencyOption> crypto;
  final List<CurrencyOption> fiat;
}

/// Provider that exposes the currencies (crypto and fiat)
@riverpod
CurrencyOptions currencyOptions(Ref ref) {
  return CurrencyOptions(
    crypto: CurrencyCatalog.cryptoOptions,
    fiat: CurrencyCatalog.fiatOptions,
  );
}

