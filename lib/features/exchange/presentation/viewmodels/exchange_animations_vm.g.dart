// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_animations_vm.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ExchangeAnimationsViewModel)
const exchangeAnimationsViewModelProvider =
    ExchangeAnimationsViewModelProvider._();

final class ExchangeAnimationsViewModelProvider
    extends
        $NotifierProvider<
          ExchangeAnimationsViewModel,
          ExchangeAnimationsState
        > {
  const ExchangeAnimationsViewModelProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exchangeAnimationsViewModelProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exchangeAnimationsViewModelHash();

  @$internal
  @override
  ExchangeAnimationsViewModel create() => ExchangeAnimationsViewModel();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExchangeAnimationsState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExchangeAnimationsState>(value),
    );
  }
}

String _$exchangeAnimationsViewModelHash() =>
    r'f06d119be3ff96f127a83980aa7652e73157c4ec';

abstract class _$ExchangeAnimationsViewModel
    extends $Notifier<ExchangeAnimationsState> {
  ExchangeAnimationsState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<ExchangeAnimationsState, ExchangeAnimationsState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<ExchangeAnimationsState, ExchangeAnimationsState>,
              ExchangeAnimationsState,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
