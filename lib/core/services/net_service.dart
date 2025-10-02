import 'package:dio/dio.dart';

import 'log_service.dart';

/// Provides the shared HTTP client configuration for the app.
class NetService {
  NetService({Dio? client}) : _dio = client ?? Dio(_defaultOptions) {
    configure();
  }

  static final BaseOptions _defaultOptions = BaseOptions(
    baseUrl: _baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    responseType: ResponseType.json,
    contentType: 'application/json',
  );

  static const String _baseUrl = 'https://74j6q7lg6a.execute-api.eu-west-1.amazonaws.com/stage';

  final Dio _dio;

  Dio get client => _dio;

  void configure() {
    _dio.interceptors.clear();
    _dio.interceptors.addAll(<Interceptor>[_LoggingInterceptor(), _RetryInterceptor(client: _dio)]);
  }

  Future<Response<dynamic>> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.get<dynamic>(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error, stackTrace) {
      logger.e('GET request failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Response<dynamic>> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.post<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error, stackTrace) {
      logger.e('POST request failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Response<dynamic>> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      return await _dio.put<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
    } on DioException catch (error, stackTrace) {
      logger.e('PUT request failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<Response<dynamic>> delete(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
  }) async {
    try {
      return await _dio.delete<dynamic>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
      );
    } on DioException catch (error, stackTrace) {
      logger.e('DELETE request failed', error: error, stackTrace: stackTrace);
      rethrow;
    }
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    logger.i('Request → ${options.method} ${options.uri}', error: options.data);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response<dynamic> response, ResponseInterceptorHandler handler) {
    logger.d('Response ← ${response.statusCode} ${response.requestOptions.uri}', error: response.data);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    logger.e('Error ↯ ${err.requestOptions.uri}', error: err, stackTrace: err.stackTrace);
    handler.next(err);
  }
}

class _RetryInterceptor extends Interceptor {
  _RetryInterceptor({required Dio client}) : _client = client;

  final Dio _client;

  static const int _maxRetries = 2;

  @override
  Future<void> onError(DioException err, ErrorInterceptorHandler handler) async {
    final RequestOptions requestOptions = err.requestOptions;

    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }

    final int retryCount = (requestOptions.extra['retryCount'] as int? ?? 0) + 1;

    if (retryCount > _maxRetries) {
      handler.next(err);
      return;
    }

    requestOptions.extra['retryCount'] = retryCount;

    try {
      final Response<dynamic> response = await _client.fetch<dynamic>(requestOptions);
      handler.resolve(response);
    } on DioException catch (retryError) {
      handler.next(retryError);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionError ||
        err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout;
  }
}
