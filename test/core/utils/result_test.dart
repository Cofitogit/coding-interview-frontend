import 'package:flutter_test/flutter_test.dart';
import 'package:eldorado_challenge/core/errors/failures.dart';
import 'package:eldorado_challenge/core/utils/result.dart';

void main() {
  group('Result<T>', () {
    group('Success', () {
      const String testValue = 'test value';
      const Success<String> success = Success<String>(testValue);

      test('should be of type Success', () {
        expect(success, isA<Success<String>>());
        expect(success, isA<Result<String>>());
      });

      test('should have correct value', () {
        expect(success.value, equals(testValue));
      });

      test('isSuccess should return true', () {
        expect(success.isSuccess, isTrue);
      });

      test('isFailure should return false', () {
        expect(success.isFailure, isFalse);
      });

      test('valueOrNull should return value', () {
        expect(success.valueOrNull, equals(testValue));
      });

      test('failureOrNull should return null', () {
        expect(success.failureOrNull, isNull);
      });

      test('errorMessageOrNull should return null', () {
        expect(success.errorMessageOrNull, isNull);
      });

      test('fold should call onSuccess', () {
        String? result;

        success.fold(
          onSuccess: (String value) {
            result = value;
            return value;
          },
          onFailure: (AppFailure failure) {
            fail('Should not call onFailure');
          },
        );

        expect(result, equals(testValue));
      });

      test('toString should include value', () {
        expect(success.toString(), equals('Success($testValue)'));
      });
    });

    group('Failure', () {
      const NetworkFailure networkFailure = NetworkFailure(
        message: 'Network error',
        details: 'Connection timeout',
      );
      const Failure<String> failure = Failure<String>(networkFailure);

      test('should be of type Failure', () {
        expect(failure, isA<Failure<String>>());
        expect(failure, isA<Result<String>>());
      });

      test('should have correct failure', () {
        expect(failure.failure, equals(networkFailure));
      });

      test('isSuccess should return false', () {
        expect(failure.isSuccess, isFalse);
      });

      test('isFailure should return true', () {
        expect(failure.isFailure, isTrue);
      });

      test('valueOrNull should return null', () {
        expect(failure.valueOrNull, isNull);
      });

      test('failureOrNull should return failure', () {
        expect(failure.failureOrNull, equals(networkFailure));
      });

      test('errorMessageOrNull should return failure message', () {
        expect(failure.errorMessageOrNull, equals('Network error'));
      });

      test('message getter should return failure message', () {
        expect(failure.message, equals('Network error'));
      });

      test('fold should call onFailure', () {
        AppFailure? result;

        failure.fold(
          onSuccess: (String value) {
            fail('Should not call onSuccess');
          },
          onFailure: (AppFailure f) {
            result = f;
            return 'error handled';
          },
        );

        expect(result, equals(networkFailure));
      });

      test('toString should include message', () {
        expect(failure.toString(), contains('Network error'));
      });
    });

    group('Different Failure types', () {
      test('should work with ValidationFailure', () {
        const ValidationFailure validationFailure = ValidationFailure('Invalid input');
        const Failure<int> failure = Failure<int>(validationFailure);

        expect(failure.failureOrNull, isA<ValidationFailure>());
        expect(failure.message, equals('Invalid input'));
      });

      test('should work with ServerFailure', () {
        const ServerFailure serverFailure = ServerFailure(
          message: 'Server error',
          details: 'HTTP 500',
        );
        const Failure<double> failure = Failure<double>(serverFailure);

        expect(failure.failureOrNull, isA<ServerFailure>());
        expect(failure.message, equals('Server error'));
        expect(failure.failureOrNull?.details, equals('HTTP 500'));
      });

      test('should work with NoDataFailure', () {
        const NoDataFailure noDataFailure = NoDataFailure();
        const Failure<List<String>> failure = Failure<List<String>>(noDataFailure);

        expect(failure.failureOrNull, isA<NoDataFailure>());
        expect(failure.message, isNotEmpty);
      });

      test('should work with UnknownFailure', () {
        const UnknownFailure unknownFailure = UnknownFailure(
          message: 'Something went wrong',
          details: 'Stack trace here',
        );
        const Failure<bool> failure = Failure<bool>(unknownFailure);

        expect(failure.failureOrNull, isA<UnknownFailure>());
        expect(failure.message, equals('Something went wrong'));
      });
    });

    group('Generic types', () {
      test('should work with custom objects', () {
        final CustomObject obj = CustomObject(id: 1, name: 'Test');
        final Success<CustomObject> success = Success<CustomObject>(obj);

        expect(success.value.id, equals(1));
        expect(success.value.name, equals('Test'));
      });

      test('should work with nullable types', () {
        const Success<String?> success = Success<String?>(null);
        expect(success.value, isNull);
        expect(success.valueOrNull, isNull);
      });

      test('should work with void type', () {
        const Success<void> success = Success<void>(null);
        expect(success, isA<Success<void>>());

        const Failure<void> failure = Failure<void>(ValidationFailure('Error'));
        expect(failure.failureOrNull, isA<ValidationFailure>());
      });
    });

    group('fold transformations', () {
      test('should transform Success value', () {
        const Success<int> success = Success<int>(42);

        final String result = success.fold(
          onSuccess: (int value) => 'Value is $value',
          onFailure: (AppFailure failure) => 'Error: ${failure.message}',
        );

        expect(result, equals('Value is 42'));
      });

      test('should transform Failure message', () {
        const Failure<int> failure = Failure<int>(NetworkFailure(message: 'No connection'));

        final String result = failure.fold(
          onSuccess: (int value) => 'Value is $value',
          onFailure: (AppFailure f) => 'Error: ${f.message}',
        );

        expect(result, equals('Error: No connection'));
      });

      test('should support different return types in fold', () {
        const Success<String> success = Success<String>('hello');

        final int length = success.fold(
          onSuccess: (String value) => value.length,
          onFailure: (AppFailure failure) => -1,
        );

        expect(length, equals(5));
      });
    });
  });
}

// Helper class for testing
class CustomObject {
  CustomObject({required this.id, required this.name});

  final int id;
  final String name;
}

