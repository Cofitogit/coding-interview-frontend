/// Base exception for all app-related errors
abstract class AppException implements Exception {
  const AppException(this.message, {this.technicalDetails});

  final String message;
  final String? technicalDetails;

  @override
  String toString() => technicalDetails != null 
    ? '$message (Details: $technicalDetails)' 
    : message;
}

/// Thrown when no offers are available for the requested exchange
class NoOffersAvailableException extends AppException {
  const NoOffersAvailableException({
    String? technicalDetails,
  }) : super(
          'No hay ofertas disponibles para este intercambio en este momento',
          technicalDetails: technicalDetails,
        );
}

/// Thrown when the server returns an error
class ServerException extends AppException {
  const ServerException({
    String? technicalDetails,
  }) : super(
          'Error del servidor. Por favor, intenta nuevamente',
          technicalDetails: technicalDetails,
        );
}

/// Thrown when there's a network connectivity issue
class NetworkException extends AppException {
  const NetworkException({
    String? technicalDetails,
  }) : super(
          'Sin conexión a internet. Verifica tu conexión',
          technicalDetails: technicalDetails,
        );
}

/// Thrown when the request times out
class TimeoutException extends AppException {
  const TimeoutException({
    String? technicalDetails,
  }) : super(
          'La solicitud tardó demasiado. Intenta nuevamente',
          technicalDetails: technicalDetails,
        );
}

/// Thrown when data parsing fails
class DataParsingException extends AppException {
  const DataParsingException({
    String? technicalDetails,
  }) : super(
          'Error al procesar la información recibida',
          technicalDetails: technicalDetails,
        );
}

/// Thrown for unexpected errors
class UnexpectedException extends AppException {
  const UnexpectedException({
    String? technicalDetails,
  }) : super(
          'Ocurrió un error inesperado. Por favor, intenta nuevamente',
          technicalDetails: technicalDetails,
        );
}

