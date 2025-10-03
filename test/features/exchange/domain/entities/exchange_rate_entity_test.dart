import 'package:flutter_test/flutter_test.dart';
import 'package:eldorado_challenge/features/exchange/domain/entities/exchange_rate_entity.dart';

void main() {
  group('ExchangeRateEntity', () {
    const double testRate = 50.5;
    const double testMinutes = 10.5;
    const double testMinLimit = 100.0;
    const double testMaxLimit = 10000.0;

    late ExchangeRateEntity entity;

    setUp(() {
      entity = const ExchangeRateEntity(
        rate: testRate,
        estimatedMinutes: testMinutes,
        minLimit: testMinLimit,
        maxLimit: testMaxLimit,
      );
    });

    group('calculateReceiveAmount', () {
      test('should calculate correctly for crypto to fiat', () {
        const double amount = 100.0;
        const bool isCryptoToFiat = true;

        final double result = entity.calculateReceiveAmount(
          amount: amount,
          isCryptoToFiat: isCryptoToFiat,
        );

        expect(result, equals(amount * testRate)); // 100 * 50.5 = 5050
      });

      test('should calculate correctly for fiat to crypto', () {
        const double amount = 5050.0;
        const bool isCryptoToFiat = false;

        final double result = entity.calculateReceiveAmount(
          amount: amount,
          isCryptoToFiat: isCryptoToFiat,
        );

        expect(result, equals(amount / testRate)); // 5050 / 50.5 = 100
      });

      test('should return 0 when amount is 0', () {
        final double result = entity.calculateReceiveAmount(
          amount: 0.0,
          isCryptoToFiat: true,
        );

        expect(result, equals(0.0));
      });

      test('should return 0 when rate is 0', () {
        const ExchangeRateEntity zeroRateEntity = ExchangeRateEntity(
          rate: 0.0,
          estimatedMinutes: testMinutes,
        );

        final double result = zeroRateEntity.calculateReceiveAmount(
          amount: 100.0,
          isCryptoToFiat: true,
        );

        expect(result, equals(0.0));
      });

      test('should return 0 when amount is negative', () {
        final double result = entity.calculateReceiveAmount(
          amount: -100.0,
          isCryptoToFiat: true,
        );

        expect(result, equals(0.0));
      });
    });

    group('isAmountValid', () {
      test('should return true when amount is within limits', () {
        expect(entity.isAmountValid(500.0), isTrue);
        expect(entity.isAmountValid(100.0), isTrue); // min limit
        expect(entity.isAmountValid(10000.0), isTrue); // max limit
      });

      test('should return false when amount is below min limit', () {
        expect(entity.isAmountValid(99.0), isFalse);
        expect(entity.isAmountValid(0.0), isFalse);
      });

      test('should return false when amount is above max limit', () {
        expect(entity.isAmountValid(10001.0), isFalse);
        expect(entity.isAmountValid(20000.0), isFalse);
      });

      test('should return true when no limits are set', () {
        const ExchangeRateEntity noLimitsEntity = ExchangeRateEntity(
          rate: testRate,
          estimatedMinutes: testMinutes,
        );

        expect(noLimitsEntity.isAmountValid(0.0), isTrue);
        expect(noLimitsEntity.isAmountValid(999999.0), isTrue);
      });
    });

    group('formatEstimatedMinutes', () {
      test('should format with default decimals (1)', () {
        expect(entity.formatEstimatedMinutes(), equals('10.5'));
      });

      test('should format with 0 decimals', () {
        // 10.5 rounds to 11 when formatted with 0 decimals
        expect(entity.formatEstimatedMinutes(decimals: 0), equals('11'));
      });

      test('should format with 2 decimals', () {
        expect(entity.formatEstimatedMinutes(decimals: 2), equals('10.50'));
      });
    });

    group('equality', () {
      test('should be equal when all properties match', () {
        const ExchangeRateEntity entity1 = ExchangeRateEntity(
          rate: testRate,
          estimatedMinutes: testMinutes,
          minLimit: testMinLimit,
          maxLimit: testMaxLimit,
        );

        const ExchangeRateEntity entity2 = ExchangeRateEntity(
          rate: testRate,
          estimatedMinutes: testMinutes,
          minLimit: testMinLimit,
          maxLimit: testMaxLimit,
        );

        expect(entity1, equals(entity2));
        expect(entity1.hashCode, equals(entity2.hashCode));
      });

      test('should not be equal when properties differ', () {
        const ExchangeRateEntity entity1 = ExchangeRateEntity(
          rate: testRate,
          estimatedMinutes: testMinutes,
        );

        const ExchangeRateEntity entity2 = ExchangeRateEntity(
          rate: testRate + 1,
          estimatedMinutes: testMinutes,
        );

        expect(entity1, isNot(equals(entity2)));
      });
    });

    group('toString', () {
      test('should include all properties', () {
        final String result = entity.toString();

        expect(result, contains('rate: $testRate'));
        expect(result, contains('estimatedMinutes: $testMinutes'));
        expect(result, contains('minLimit: $testMinLimit'));
        expect(result, contains('maxLimit: $testMaxLimit'));
      });
    });
  });
}

