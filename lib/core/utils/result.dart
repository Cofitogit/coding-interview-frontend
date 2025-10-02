sealed class Result<T> {
  const Result();
  
  bool get isSuccess => this is Success<T>;
  
  bool get isFailure => this is Failure<T>;
  
  T? get valueOrNull => switch (this) {
    Success<T>(value: final T v) => v,
    _ => null,
  };
  
  String? get errorOrNull => switch (this) {
    Failure<T>(message: final String m) => m,
    _ => null,
  };
  
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(String message) onFailure,
  }) {
    return switch (this) {
      Success<T>(value: final T v) => onSuccess(v),
      Failure<T>(message: final String m) => onFailure(m),
    };
  }
}

final class Success<T> extends Result<T> {
  const Success(this.value);
  final T value;
  
  @override
  String toString() => 'Success($value)';
}

final class Failure<T> extends Result<T> {
  const Failure(this.message, [this.exception]);
  final String message;
  final Exception? exception;
  
  @override
  String toString() => 'Failure($message)';
}

