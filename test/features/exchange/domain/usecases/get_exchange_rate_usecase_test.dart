import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:eldorado_challenge/core/errors/failures.dart';
import 'package:eldorado_challenge/core/models/currency_option.dart';
import 'package:eldorado_challenge/core/utils/result.dart';
import 'package:eldorado_challenge/features/exchange/domain/entities/exchange_rate_entity.dart';
import 'package:eldorado_challenge/features/exchange/domain/repositories/exchange_repository.dart';
import 'package:eldorado_challenge/features/exchange/domain/usecases/get_exchange_rate_usecase.dart';

// Mock Repository
class MockExchangeRepository extends Mock implements ExchangeRepository {}

void main() {
  late GetExchangeRateUseCase useCase;
  late MockExchangeRepository mockRepository;

  setUpAll(() {
    // Register fallback values for Mocktail
    registerFallbackValue(const CurrencyOption(
      id: 'FALLBACK',
      code: 'FB',
      name: 'Fallback',
      description: 'Fallback currency',
      kind: CurrencyKind.crypto,
    ));
  });

  setUp(() {
    mockRepository = MockExchangeRepository();
    useCase = GetExchangeRateUseCase(mockRepository);
  });

  const CurrencyOption fromCurrency = CurrencyOption(
    id: 'TATUM-TRON-USDT',
    code: 'USDT',
    name: 'Tether',
    description: 'Tether USD',
    kind: CurrencyKind.crypto,
  );

  const CurrencyOption toCurrency = CurrencyOption(
    id: 'VES',
    code: 'VES',
    name: 'Bolívar',
    description: 'Bolívar Venezolano',
    kind: CurrencyKind.fiat,
  );

  const ExchangeRateEntity tEntity = ExchangeRateEntity(
    rate: 50.5,
    estimatedMinutes: 10.0,
    minLimit: 100.0,
    maxLimit: 10000.0,
  );

  group('GetExchangeRateUseCase', () {
    test('should return entity when repository succeeds', () async {
      // Arrange
      when(
        () => mockRepository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: '100',
        ),
      ).thenAnswer((_) async => const Success<ExchangeRateEntity>(tEntity));

      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: toCurrency,
        amount: '100',
      );

      // Assert
      expect(result, isA<Success<ExchangeRateEntity>>());
      expect(result.valueOrNull, equals(tEntity));
      verify(
        () => mockRepository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: '100',
        ),
      ).called(1);
    });

    test('should return ValidationFailure when amount is empty', () async {
      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: toCurrency,
        amount: '',
      );

      // Assert
      expect(result, isA<Failure<ExchangeRateEntity>>());
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(result.failureOrNull?.message, equals('El monto no puede estar vacío'));
      verifyNever(
        () => mockRepository.getExchangeRate(
          from: any(named: 'from'),
          to: any(named: 'to'),
          amount: any(named: 'amount'),
        ),
      );
    });

    test('should return ValidationFailure when amount is not a number', () async {
      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: toCurrency,
        amount: 'abc',
      );

      // Assert
      expect(result, isA<Failure<ExchangeRateEntity>>());
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(result.failureOrNull?.message, equals('El monto debe ser un número válido'));
    });

    test('should return ValidationFailure when amount is zero', () async {
      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: toCurrency,
        amount: '0',
      );

      // Assert
      expect(result, isA<Failure<ExchangeRateEntity>>());
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(result.failureOrNull?.message, equals('El monto debe ser mayor a 0'));
    });

    test('should return ValidationFailure when amount is negative', () async {
      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: toCurrency,
        amount: '-100',
      );

      // Assert
      expect(result, isA<Failure<ExchangeRateEntity>>());
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(result.failureOrNull?.message, equals('El monto debe ser mayor a 0'));
    });

    test('should return ValidationFailure when currencies are the same', () async {
      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: fromCurrency, // same currency
        amount: '100',
      );

      // Assert
      expect(result, isA<Failure<ExchangeRateEntity>>());
      expect(result.failureOrNull, isA<ValidationFailure>());
      expect(result.failureOrNull?.message, equals('Las monedas deben ser diferentes'));
    });

    test('should propagate NetworkFailure from repository', () async {
      // Arrange
      const NetworkFailure networkFailure = NetworkFailure();
      when(
        () => mockRepository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: '100',
        ),
      ).thenAnswer((_) async => const Failure<ExchangeRateEntity>(networkFailure));

      // Act
      final Result<ExchangeRateEntity> result = await useCase(
        from: fromCurrency,
        to: toCurrency,
        amount: '100',
      );

      // Assert
      expect(result, isA<Failure<ExchangeRateEntity>>());
      expect(result.failureOrNull, isA<NetworkFailure>());
    });
  });
}

