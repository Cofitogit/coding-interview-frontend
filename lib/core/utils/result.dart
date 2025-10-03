import '../errors/failures.dart';

sealed class Result<T> {
  const Result();
  
  bool get isSuccess => this is Success<T>;
  
  bool get isFailure => this is Failure<T>;
  
  T? get valueOrNull => switch (this) {
    Success<T>(value: final T v) => v,
    _ => null,
  };
  
  AppFailure? get failureOrNull => switch (this) {
    Failure<T>(failure: final AppFailure f) => f,
    _ => null,
  };
  
  String? get errorMessageOrNull => failureOrNull?.message;
  
  R fold<R>({
    required R Function(T value) onSuccess,
    required R Function(AppFailure failure) onFailure,
  }) {
    return switch (this) {
      Success<T>(value: final T v) => onSuccess(v),
      Failure<T>(failure: final AppFailure f) => onFailure(f),
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
  const Failure(this.failure);
  final AppFailure failure;
  
  String get message => failure.message;
  
  @override
  String toString() => 'Failure(${failure.message})';
}

