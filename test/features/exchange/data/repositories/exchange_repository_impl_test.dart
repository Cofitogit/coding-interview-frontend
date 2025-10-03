import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:eldorado_challenge/core/errors/exceptions.dart';
import 'package:eldorado_challenge/core/errors/failures.dart';
import 'package:eldorado_challenge/core/models/currency_option.dart';
import 'package:eldorado_challenge/core/utils/result.dart';
import 'package:eldorado_challenge/features/exchange/data/datasources/exchange_remote_datasource.dart';
import 'package:eldorado_challenge/features/exchange/data/models/exchange_rate_dto.dart';
import 'package:eldorado_challenge/features/exchange/data/repositories/exchange_repository_impl.dart';
import 'package:eldorado_challenge/features/exchange/domain/entities/exchange_rate_entity.dart';

// Mock DataSource
class MockExchangeRemoteDataSource extends Mock implements ExchangeRemoteDataSource {}

void main() {
  late ExchangeRepositoryImpl repository;
  late MockExchangeRemoteDataSource mockDataSource;

  setUp(() {
    mockDataSource = MockExchangeRemoteDataSource();
    repository = ExchangeRepositoryImpl(remoteDataSource: mockDataSource);
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

  const String testAmount = '100';

  const ExchangeRateDTO tDto = ExchangeRateDTO(
    rate: 50.5,
    estimatedMinutes: 10.0,
    minLimit: 100.0,
    maxLimit: 10000.0,
  );

  group('ExchangeRepositoryImpl', () {
    group('getExchangeRate', () {
      test('should return Success with entity when dataSource succeeds', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenAnswer((_) async => tDto);

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Success<ExchangeRateEntity>>());
        final ExchangeRateEntity? entity = result.valueOrNull;
        expect(entity?.rate, equals(tDto.rate));
        expect(entity?.estimatedMinutes, equals(tDto.estimatedMinutes));
        expect(entity?.minLimit, equals(tDto.minLimit));
        expect(entity?.maxLimit, equals(tDto.maxLimit));

        verify(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).called(1);
      });

      test('should return NoDataFailure when NoOffersAvailableException is thrown', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(const NoOffersAvailableException());

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        expect(result.failureOrNull, isA<NoDataFailure>());
      });

      test('should return NetworkFailure when NetworkException is thrown', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(const NetworkException());

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        expect(result.failureOrNull, isA<NetworkFailure>());
      });

      test('should return NetworkFailure when TimeoutException is thrown', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(const TimeoutException());

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        expect(result.failureOrNull, isA<NetworkFailure>());
      });

      test('should return ServerFailure when ServerException is thrown', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(const ServerException());

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        expect(result.failureOrNull, isA<ServerFailure>());
      });

      test('should return UnknownFailure when generic AppException is thrown', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(const DataParsingException());

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        expect(result.failureOrNull, isA<UnknownFailure>());
      });

      test('should return UnknownFailure when unexpected error is thrown', () async {
        // Arrange
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(Exception('Unexpected error'));

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        expect(result.failureOrNull, isA<UnknownFailure>());
        expect(result.failureOrNull?.message, equals('Ocurrió un error inesperado'));
      });

      test('should preserve technical details in failures', () async {
        // Arrange
        const String technicalDetails = 'HTTP 500: Internal Server Error';
        when(
          () => mockDataSource.getExchangeRate(
            from: fromCurrency,
            to: toCurrency,
            amount: testAmount,
          ),
        ).thenThrow(const ServerException(technicalDetails: technicalDetails));

        // Act
        final Result<ExchangeRateEntity> result = await repository.getExchangeRate(
          from: fromCurrency,
          to: toCurrency,
          amount: testAmount,
        );

        // Assert
        expect(result, isA<Failure<ExchangeRateEntity>>());
        final ServerFailure? failure = result.failureOrNull as ServerFailure?;
        expect(failure?.details, equals(technicalDetails));
      });
    });
  });
}

