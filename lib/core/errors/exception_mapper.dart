import 'package:dio/dio.dart';
import 'exceptions.dart';

/// Maps common exceptions to AppException types
class ExceptionMapper {
  const ExceptionMapper._();

  /// Converts DioException to AppException
  static AppException fromDioException(DioException e) {
    // Timeout errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return TimeoutException(
        technicalDetails: 'Timeout type: ${e.type}',
      );
    }

    // Network connectivity errors
    if (e.type == DioExceptionType.connectionError) {
      return NetworkException(
        technicalDetails: e.message,
      );
    }

    // Server errors (5xx)
    if (e.response != null) {
      final int? statusCode = e.response?.statusCode;
      if (statusCode != null && statusCode >= 500) {
        return ServerException(
          technicalDetails: 'HTTP $statusCode: ${e.response?.statusMessage}',
        );
      }
    }

    // Default to unexpected error
    return UnexpectedException(
      technicalDetails: 'DioException: ${e.message}',
    );
  }

  /// Wraps a function call and converts any DioException to AppException
  static Future<T> wrapDioCall<T>(Future<T> Function() call) async {
    try {
      return await call();
    } on AppException {
      rethrow; // Re-throw custom exceptions as-is
    } on DioException catch (e) {
      throw fromDioException(e);
    }
  }
}

