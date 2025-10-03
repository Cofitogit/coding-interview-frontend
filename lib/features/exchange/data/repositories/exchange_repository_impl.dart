import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/models/currency_option.dart';
import '../../../../core/utils/result.dart';
import '../../domain/entities/exchange_rate_entity.dart';
import '../../domain/repositories/exchange_repository.dart';
import '../datasources/exchange_remote_datasource.dart';
import '../models/exchange_rate_dto.dart';

class ExchangeRepositoryImpl implements ExchangeRepository {
  ExchangeRepositoryImpl({required ExchangeRemoteDataSource remoteDataSource})
      : _remoteDataSource = remoteDataSource;

  final ExchangeRemoteDataSource _remoteDataSource;

  @override
  Future<Result<ExchangeRateEntity>> getExchangeRate({
    required CurrencyOption from,
    required CurrencyOption to,
    required String amount,
  }) async {
    try {
      final ExchangeRateDTO dto = await _remoteDataSource.getExchangeRate(
        from: from,
        to: to,
        amount: amount,
      );

      final ExchangeRateEntity entity = dto.toEntity();

      return Success<ExchangeRateEntity>(entity);
    } on NoOffersAvailableException catch (e) {
      return Failure<ExchangeRateEntity>(
        NoDataFailure(
          message: e.message,
          details: e.technicalDetails,
        ),
      );
    } on NetworkException catch (e) {
      return Failure<ExchangeRateEntity>(
        NetworkFailure(
          message: e.message,
          details: e.technicalDetails,
        ),
      );
    } on TimeoutException catch (e) {
      return Failure<ExchangeRateEntity>(
        NetworkFailure(
          message: e.message,
          details: e.technicalDetails,
        ),
      );
    } on ServerException catch (e) {
      return Failure<ExchangeRateEntity>(
        ServerFailure(
          message: e.message,
          details: e.technicalDetails,
        ),
      );
    } on AppException catch (e) {
      // Catch-all for other custom exceptions
      return Failure<ExchangeRateEntity>(
        UnknownFailure(
          message: e.message,
          details: e.technicalDetails,
        ),
      );
    } catch (e) {
      // Fallback for truly unexpected errors
      return Failure<ExchangeRateEntity>(
        UnknownFailure(
          message: 'Ocurrió un error inesperado',
          details: e.toString(),
        ),
      );
    }
  }
}

