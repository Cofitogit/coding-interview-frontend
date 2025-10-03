// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_options_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider that exposes the currencies (crypto and fiat)

@ProviderFor(currencyOptions)
const currencyOptionsProvider = CurrencyOptionsProvider._();

/// Provider that exposes the currencies (crypto and fiat)

final class CurrencyOptionsProvider
    extends
        $FunctionalProvider<CurrencyOptions, CurrencyOptions, CurrencyOptions>
    with $Provider<CurrencyOptions> {
  /// Provider that exposes the currencies (crypto and fiat)
  const CurrencyOptionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currencyOptionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currencyOptionsHash();

  @$internal
  @override
  $ProviderElement<CurrencyOptions> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CurrencyOptions create(Ref ref) {
    return currencyOptions(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CurrencyOptions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CurrencyOptions>(value),
    );
  }
}

String _$currencyOptionsHash() => r'7c1f9cdc4228e9f365e40d21fe4acdf6778bcd79';
