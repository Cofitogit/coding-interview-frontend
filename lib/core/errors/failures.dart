/// Class for all app failures
abstract class AppFailure {
  const AppFailure(this.message, {this.details});
  
  final String message;
  final String? details;
  
  @override
  String toString() => message;
}

/// Network failure (timeout, no internet, etc.)
class NetworkFailure extends AppFailure {
  const NetworkFailure({
    String message = 'Error de conexión. Verifica tu internet.',
    String? details,
  }) : super(message, details: details);
}

/// Server failure (500, 503, etc.)
class ServerFailure extends AppFailure {
  const ServerFailure({
    String message = 'Error del servidor. Intenta más tarde.',
    this.statusCode,
    String? details,
  }) : super(message, details: details);
  
  final int? statusCode;
}

/// Validation failure (invalid fields)
class ValidationFailure extends AppFailure {
  const ValidationFailure(super.message);
}

/// Unknown failure
class UnknownFailure extends AppFailure {
  const UnknownFailure({
    String message = 'Ocurrió un error inesperado',
    String? details,
  }) : super(message, details: details);
}

/// No data available
class NoDataFailure extends AppFailure {
  const NoDataFailure({
    String message = 'No hay datos disponibles',
    String? details,
  }) : super(message, details: details);
}

