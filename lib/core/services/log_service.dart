import 'package:logger/logger.dart';

import '../config/args.dart';

/// Provides a centralized logging utility for the application.
final LogService logger = LogService._();

/// Wraps the `logger` package with project-specific configuration and API.
class LogService {
  LogService._();

  final Logger _logger = Logger(
    level: Args.logLevel,
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 6,
      lineLength: 80,
      colors: false,
      printEmojis: false,
      dateTimeFormat: DateTimeFormat.onlyTime,
    ),
  );

  void t(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Args.traceLevel,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void d(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.debug,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void i(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.info,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void w(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.warning,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void e(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.error,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void f(
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _log(
      Level.fatal,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void _log(
    Level level,
    String message, {
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.log(
      level,
      message,
      error: error,
      stackTrace: stackTrace,
    );
  }
}

