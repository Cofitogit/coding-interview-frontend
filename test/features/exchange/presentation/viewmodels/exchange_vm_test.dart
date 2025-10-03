import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod/riverpod.dart';
import 'package:eldorado_challenge/core/errors/failures.dart';
import 'package:eldorado_challenge/core/models/currency_option.dart';
import 'package:eldorado_challenge/core/utils/result.dart';
import 'package:eldorado_challenge/features/exchange/domain/entities/exchange_rate_entity.dart';
import 'package:eldorado_challenge/features/exchange/domain/usecases/get_exchange_rate_usecase.dart';
import 'package:eldorado_challenge/features/exchange/domain/usecases/validate_exchange_usecase.dart';
import 'package:eldorado_challenge/features/exchange/presentation/state/exchange_state.dart';
import 'package:eldorado_challenge/features/exchange/presentation/viewmodels/currency_options_provider.dart';
import 'package:eldorado_challenge/features/exchange/presentation/viewmodels/exchange_dependencies.dart';
import 'package:eldorado_challenge/features/exchange/presentation/viewmodels/exchange_vm.dart';

// Mocks
class MockGetExchangeRateUseCase extends Mock implements GetExchangeRateUseCase {}

class MockValidateExchangeUseCase extends Mock implements ValidateExchangeUseCase {}

// Fakes for registerFallbackValue
class FakeCurrencyOption extends Fake implements CurrencyOption {}

class FakeExchangeRateEntity extends Fake implements ExchangeRateEntity {}

void main() {
  late MockGetExchangeRateUseCase mockGetExchangeRate;
  late MockValidateExchangeUseCase mockValidateExchange;
  late ProviderContainer container;

  setUpAll(() {
    // Register fallback values for Mocktail
    registerFallbackValue(FakeCurrencyOption());
    registerFallbackValue(FakeExchangeRateEntity());
  });

  setUp(() {
    mockGetExchangeRate = MockGetExchangeRateUseCase();
    mockValidateExchange = MockValidateExchangeUseCase();

    // Create container with overridden providers
    container = ProviderContainer(
      overrides: [
        getExchangeRateUseCaseProvider.overrideWithValue(mockGetExchangeRate),
        validateExchangeUseCaseProvider.overrideWithValue(mockValidateExchange),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  const ExchangeRateEntity tEntity = ExchangeRateEntity(
    rate: 50.5,
    estimatedMinutes: 10.0,
    minLimit: 100.0,
    maxLimit: 10000.0,
  );

  group('ExchangeViewModel', () {
    test('should initialize with default currencies', () {
      // Act
      final ExchangeState state = container.read(exchangeViewModelProvider);

      // Assert
      expect(state.fromCurrency, isNotNull);
      expect(state.toCurrency, isNotNull);
      expect(state.amount, equals(''));
      expect(state.isLoading, isFalse);
      expect(state.recommendation, isNull);
      expect(state.errorMessage, isNull);
    });

    test('should update fromCurrency when selectFrom is called', () {
      // Arrange
      final CurrencyOptions options = container.read(currencyOptionsProvider);
      final CurrencyOption newCurrency = options.crypto.last;

      // Act
      container.read(exchangeViewModelProvider.notifier).selectFrom(newCurrency);
      final ExchangeState state = container.read(exchangeViewModelProvider);

      // Assert
      expect(state.fromCurrency, equals(newCurrency));
      expect(state.errorMessage, isNull);
      expect(state.recommendation, isNull);
    });

    test('should update toCurrency when selectTo is called', () {
      // Arrange
      final CurrencyOptions options = container.read(currencyOptionsProvider);
      final CurrencyOption newCurrency = options.fiat.last;

      // Act
      container.read(exchangeViewModelProvider.notifier).selectTo(newCurrency);
      final ExchangeState state = container.read(exchangeViewModelProvider);

      // Assert
      expect(state.toCurrency, equals(newCurrency));
      expect(state.errorMessage, isNull);
      expect(state.recommendation, isNull);
    });

    test('should swap currencies when swap is called', () {
      // Arrange
      final ExchangeState initialState = container.read(exchangeViewModelProvider);
      final CurrencyOption? initialFrom = initialState.fromCurrency;
      final CurrencyOption? initialTo = initialState.toCurrency;

      // Act
      container.read(exchangeViewModelProvider.notifier).swap();
      final ExchangeState state = container.read(exchangeViewModelProvider);

      // Assert
      expect(state.fromCurrency, equals(initialTo));
      expect(state.toCurrency, equals(initialFrom));
      expect(state.errorMessage, isNull);
      expect(state.recommendation, isNull);
    });

    test('should update amount when updateAmount is called', () {
      // Act
      container.read(exchangeViewModelProvider.notifier).updateAmount('123.45');
      final ExchangeState state = container.read(exchangeViewModelProvider);

      // Assert
      expect(state.amount, equals('123.45'));
      expect(state.errorMessage, isNull);
      expect(state.recommendation, isNull);
    });

    group('execute', () {
      test('should do nothing when canExecute is false', () async {
        // Arrange - no amount
        final ExchangeState initialState = container.read(exchangeViewModelProvider);
        expect(initialState.canExecute, isFalse);

        // Act
        await container.read(exchangeViewModelProvider.notifier).execute();

        // Assert
        verifyNever(() => mockGetExchangeRate(
              from: any(named: 'from'),
              to: any(named: 'to'),
              amount: any(named: 'amount'),
            ));
      });

      test('should set loading state during execution', () async {
        // Arrange
        container.read(exchangeViewModelProvider.notifier).updateAmount('100');
        final ExchangeState initialState = container.read(exchangeViewModelProvider);

        when(
          () => mockGetExchangeRate(
            from: initialState.fromCurrency!,
            to: initialState.toCurrency!,
            amount: '100',
          ),
        ).thenAnswer((_) async {
          // Verify loading state during execution
          final ExchangeState state = container.read(exchangeViewModelProvider);
          expect(state.isLoading, isTrue);
          return const Success<ExchangeRateEntity>(tEntity);
        });

        when(
          () => mockValidateExchange(
            amount: 100.0,
            exchangeRate: tEntity,
            currencyCode: initialState.fromCurrency!.code,
          ),
        ).thenReturn(const Success<void>(null));

        // Act
        await container.read(exchangeViewModelProvider.notifier).execute();
      });

      test('should update state with recommendation on success', () async {
        // Arrange
        container.read(exchangeViewModelProvider.notifier).updateAmount('100');
        final ExchangeState initialState = container.read(exchangeViewModelProvider);

        when(
          () => mockGetExchangeRate(
            from: initialState.fromCurrency!,
            to: initialState.toCurrency!,
            amount: '100',
          ),
        ).thenAnswer((_) async => const Success<ExchangeRateEntity>(tEntity));

        when(
          () => mockValidateExchange(
            amount: 100.0,
            exchangeRate: tEntity,
            currencyCode: initialState.fromCurrency!.code,
          ),
        ).thenReturn(const Success<void>(null));

        // Act
        await container.read(exchangeViewModelProvider.notifier).execute();
        final ExchangeState state = container.read(exchangeViewModelProvider);

        // Assert
        expect(state.isLoading, isFalse);
        expect(state.recommendation, equals(tEntity));
        expect(state.errorMessage, isNull);
      });

      test('should update state with error when getExchangeRate fails', () async {
        // Arrange
        container.read(exchangeViewModelProvider.notifier).updateAmount('100');
        const NetworkFailure failure = NetworkFailure(
          message: 'No internet connection',
        );

        when(
          () => mockGetExchangeRate(
            from: any(named: 'from'),
            to: any(named: 'to'),
            amount: '100',
          ),
        ).thenAnswer((_) async => const Failure<ExchangeRateEntity>(failure));

        // Act
        await container.read(exchangeViewModelProvider.notifier).execute();
        final ExchangeState state = container.read(exchangeViewModelProvider);

        // Assert
        expect(state.isLoading, isFalse);
        expect(state.errorMessage, equals('No internet connection'));
        expect(state.recommendation, isNull);
      });

      test('should update state with validation error when validation fails', () async {
        // Arrange
        container.read(exchangeViewModelProvider.notifier).updateAmount('50'); // Below min limit
        const ValidationFailure validationFailure = ValidationFailure(
          'Monto mínimo: 100.00 USDT',
        );

        when(
          () => mockGetExchangeRate(
            from: any(named: 'from'),
            to: any(named: 'to'),
            amount: '50',
          ),
        ).thenAnswer((_) async => const Success<ExchangeRateEntity>(tEntity));

        when(
          () => mockValidateExchange(
            amount: 50.0,
            exchangeRate: tEntity,
            currencyCode: any(named: 'currencyCode'),
          ),
        ).thenReturn(const Failure<void>(validationFailure));

        // Act
        await container.read(exchangeViewModelProvider.notifier).execute();
        final ExchangeState state = container.read(exchangeViewModelProvider);

        // Assert
        expect(state.isLoading, isFalse);
        expect(state.errorMessage, equals('Monto mínimo: 100.00 USDT'));
        expect(state.recommendation, equals(tEntity)); // Still has recommendation
      });

      test('should call useCases with correct parameters', () async {
        // Arrange
        final ExchangeState initialState = container.read(exchangeViewModelProvider);
        container.read(exchangeViewModelProvider.notifier).updateAmount('100');

        when(
          () => mockGetExchangeRate(
            from: initialState.fromCurrency!,
            to: initialState.toCurrency!,
            amount: '100',
          ),
        ).thenAnswer((_) async => const Success<ExchangeRateEntity>(tEntity));

        when(
          () => mockValidateExchange(
            amount: 100.0,
            exchangeRate: tEntity,
            currencyCode: initialState.fromCurrency!.code,
          ),
        ).thenReturn(const Success<void>(null));

        // Act
        await container.read(exchangeViewModelProvider.notifier).execute();

        // Assert
        verify(
          () => mockGetExchangeRate(
            from: initialState.fromCurrency!,
            to: initialState.toCurrency!,
            amount: '100',
          ),
        ).called(1);

        verify(
          () => mockValidateExchange(
            amount: 100.0,
            exchangeRate: tEntity,
            currencyCode: initialState.fromCurrency!.code,
          ),
        ).called(1);
      });
    });
  });
}

