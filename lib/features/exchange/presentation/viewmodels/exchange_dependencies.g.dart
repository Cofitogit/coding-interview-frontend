// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exchange_dependencies.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(exchangeRemoteDataSource)
const exchangeRemoteDataSourceProvider = ExchangeRemoteDataSourceProvider._();

final class ExchangeRemoteDataSourceProvider
    extends
        $FunctionalProvider<
          ExchangeRemoteDataSource,
          ExchangeRemoteDataSource,
          ExchangeRemoteDataSource
        >
    with $Provider<ExchangeRemoteDataSource> {
  const ExchangeRemoteDataSourceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exchangeRemoteDataSourceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exchangeRemoteDataSourceHash();

  @$internal
  @override
  $ProviderElement<ExchangeRemoteDataSource> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExchangeRemoteDataSource create(Ref ref) {
    return exchangeRemoteDataSource(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExchangeRemoteDataSource value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExchangeRemoteDataSource>(value),
    );
  }
}

String _$exchangeRemoteDataSourceHash() =>
    r'3ccd435603bc2470522e743ff761def6b0f3fee6';

@ProviderFor(exchangeRepository)
const exchangeRepositoryProvider = ExchangeRepositoryProvider._();

final class ExchangeRepositoryProvider
    extends
        $FunctionalProvider<
          ExchangeRepository,
          ExchangeRepository,
          ExchangeRepository
        >
    with $Provider<ExchangeRepository> {
  const ExchangeRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exchangeRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exchangeRepositoryHash();

  @$internal
  @override
  $ProviderElement<ExchangeRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ExchangeRepository create(Ref ref) {
    return exchangeRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ExchangeRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ExchangeRepository>(value),
    );
  }
}

String _$exchangeRepositoryHash() =>
    r'8dccd5627b3790eaf23d2a9f87621ae7daa174b5';

@ProviderFor(getExchangeRateUseCase)
const getExchangeRateUseCaseProvider = GetExchangeRateUseCaseProvider._();

final class GetExchangeRateUseCaseProvider
    extends
        $FunctionalProvider<
          GetExchangeRateUseCase,
          GetExchangeRateUseCase,
          GetExchangeRateUseCase
        >
    with $Provider<GetExchangeRateUseCase> {
  const GetExchangeRateUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getExchangeRateUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getExchangeRateUseCaseHash();

  @$internal
  @override
  $ProviderElement<GetExchangeRateUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  GetExchangeRateUseCase create(Ref ref) {
    return getExchangeRateUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GetExchangeRateUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GetExchangeRateUseCase>(value),
    );
  }
}

String _$getExchangeRateUseCaseHash() =>
    r'3716008694ce1f4af2477b0bd1013c2c9c55020e';

@ProviderFor(validateExchangeUseCase)
const validateExchangeUseCaseProvider = ValidateExchangeUseCaseProvider._();

final class ValidateExchangeUseCaseProvider
    extends
        $FunctionalProvider<
          ValidateExchangeUseCase,
          ValidateExchangeUseCase,
          ValidateExchangeUseCase
        >
    with $Provider<ValidateExchangeUseCase> {
  const ValidateExchangeUseCaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'validateExchangeUseCaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$validateExchangeUseCaseHash();

  @$internal
  @override
  $ProviderElement<ValidateExchangeUseCase> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ValidateExchangeUseCase create(Ref ref) {
    return validateExchangeUseCase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ValidateExchangeUseCase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ValidateExchangeUseCase>(value),
    );
  }
}

String _$validateExchangeUseCaseHash() =>
    r'336131c87acd20588e9b645334f2979610e88f2c';
