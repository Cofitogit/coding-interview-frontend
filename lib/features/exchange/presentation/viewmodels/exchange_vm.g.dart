// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExchangeViewModel)
const exchangeViewModelProvider = ExchangeViewModelProvider._();

final class ExchangeViewModelProvider
    extends $NotifierProvider<ExchangeViewModel, ExchangeState> {
  const ExchangeViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exchangeViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exchangeViewModelHash();

  @$internal
  @override
  ExchangeViewModel create() => ExchangeViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExchangeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExchangeState>(value),
    );
  }
}

String _$exchangeViewModelHash() => r'9ba47fa9d504f474294eb2f2e4a1d7ffb98ad803';

abstract class _$ExchangeViewModel extends $Notifier<ExchangeState> {
  ExchangeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<ExchangeState, ExchangeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExchangeState, ExchangeState>,
              ExchangeState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
