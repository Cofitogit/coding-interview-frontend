import 'package:dio/dio.dart';
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
    } on DioException catch (e) {
      // TODO - this is a bad approach, we should use a more elegant way to handle errors
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        return const Failure<ExchangeRateEntity>(
          'Tiempo de espera agotado. Intenta nuevamente.',
        );
      }

      if (e.type == DioExceptionType.connectionError) {
        return const Failure<ExchangeRateEntity>(
          'Error de conexión. Verifica tu internet.',
        );
      }

      //! Server errors
      if (e.response != null) {
        final int? statusCode = e.response?.statusCode;
        if (statusCode != null && statusCode >= 500) {
          return const Failure<ExchangeRateEntity>(
            'Error del servidor. Intenta más tarde.',
          );
        }
      }

      return Failure<ExchangeRateEntity>(
        'Error al obtener la tasa de cambio: ${e.message}',
      );
    } catch (e) {
      //! Unexpected errors
      return Failure<ExchangeRateEntity>(
        'Error inesperado: ${e.toString()}',
      );
    }
  }
}

