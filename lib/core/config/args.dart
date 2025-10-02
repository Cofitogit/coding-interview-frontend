import 'package:logger/logger.dart';

/// Configures runtime arguments and environment-based flags.
class Args {
  Args._();

  /// Current environment identifier.
  static const String environment =
      String.fromEnvironment('APP_ENV', defaultValue: 'challenge');

  /// Determines the global log level according to the environment.
  static Level get logLevel {
    switch (environment) {
      case 'prod':
        return Level.warning;
      case 'staging':
        return Level.info;
      case 'dev':
        return Level.debug;
      case 'challenge':
        return Level.trace;
      default:
        return Level.info;
    }
  }

  /// Level used for verbose/trace logs.
  static Level get traceLevel => Level.trace;

  /// Useful placeholder for future server URL configuration.
  /// TODO: Map `environment` to a real server URL when environments are ready.
}

