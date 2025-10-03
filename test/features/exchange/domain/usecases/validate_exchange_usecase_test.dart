import 'package:flutter_test/flutter_test.dart';
import 'package:eldorado_challenge/core/errors/failures.dart';
import 'package:eldorado_challenge/core/utils/result.dart';
import 'package:eldorado_challenge/features/exchange/domain/entities/exchange_rate_entity.dart';
import 'package:eldorado_challenge/features/exchange/domain/usecases/validate_exchange_usecase.dart';

void main() {
  late ValidateExchangeUseCase useCase;

  setUp(() {
    useCase = const ValidateExchangeUseCase();
  });

  const ExchangeRateEntity entityWithLimits = ExchangeRateEntity(
    rate: 50.5,
    estimatedMinutes: 10.0,
    minLimit: 100.0,
    maxLimit: 10000.0,
  );

  const ExchangeRateEntity entityWithoutLimits = ExchangeRateEntity(
    rate: 50.5,
    estimatedMinutes: 10.0,
  );

  const String currencyCode = 'USDT';

  group('ValidateExchangeUseCase', () {
    group('with limits', () {
      test('should return Success when amount is within limits', () {
        // Act
        final Result<void> result = useCase(
          amount: 500.0,
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Success<void>>());
      });

      test('should return Success when amount equals min limit', () {
        // Act
        final Result<void> result = useCase(
          amount: 100.0, // exactly at min limit
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Success<void>>());
      });

      test('should return Success when amount equals max limit', () {
        // Act
        final Result<void> result = useCase(
          amount: 10000.0, // exactly at max limit
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Success<void>>());
      });

      test('should return ValidationFailure when amount is below min limit', () {
        // Act
        final Result<void> result = useCase(
          amount: 99.0,
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Failure<void>>());
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          result.failureOrNull?.message,
          equals('Monto mínimo: 100.00 $currencyCode'),
        );
      });

      test('should return ValidationFailure when amount is above max limit', () {
        // Act
        final Result<void> result = useCase(
          amount: 10001.0,
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Failure<void>>());
        expect(result.failureOrNull, isA<ValidationFailure>());
        expect(
          result.failureOrNull?.message,
          equals('Monto máximo: 10000.00 $currencyCode'),
        );
      });

      test('should include currency code in error message', () {
        // Act
        final Result<void> result = useCase(
          amount: 50.0,
          exchangeRate: entityWithLimits,
          currencyCode: 'BTC',
        );

        // Assert
        expect(result, isA<Failure<void>>());
        expect(result.failureOrNull?.message, contains('BTC'));
      });
    });

    group('without limits', () {
      test('should return Success for any amount', () {
        // Act
        final Result<void> result1 = useCase(
          amount: 0.0,
          exchangeRate: entityWithoutLimits,
          currencyCode: currencyCode,
        );

        final Result<void> result2 = useCase(
          amount: 999999.0,
          exchangeRate: entityWithoutLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result1, isA<Success<void>>());
        expect(result2, isA<Success<void>>());
      });
    });

    group('edge cases', () {
      test('should handle zero amount with limits', () {
        // Act
        final Result<void> result = useCase(
          amount: 0.0,
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Failure<void>>());
        expect(result.failureOrNull, isA<ValidationFailure>());
      });

      test('should handle very large amounts', () {
        const ExchangeRateEntity largeLimit = ExchangeRateEntity(
          rate: 50.5,
          estimatedMinutes: 10.0,
          minLimit: 1.0,
          maxLimit: 1000000000.0,
        );

        // Act
        final Result<void> result = useCase(
          amount: 999999999.0,
          exchangeRate: largeLimit,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Success<void>>());
      });

      test('should handle decimal amounts', () {
        // Act
        final Result<void> result = useCase(
          amount: 100.5,
          exchangeRate: entityWithLimits,
          currencyCode: currencyCode,
        );

        // Assert
        expect(result, isA<Success<void>>());
      });
    });
  });
}

