import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../data/datasources/exchange_remote_datasource.dart';
import '../../data/repositories/exchange_repository_impl.dart';
import '../../domain/repositories/exchange_repository.dart';
import '../../domain/usecases/get_exchange_rate_usecase.dart';
import '../../domain/usecases/validate_exchange_usecase.dart';

part 'exchange_dependencies.g.dart';

// ==================== Data Layer ====================

@riverpod
ExchangeRemoteDataSource exchangeRemoteDataSource(Ref ref) {
  return ExchangeRemoteDataSourceImpl();
}

@riverpod
ExchangeRepository exchangeRepository(Ref ref) {
  final ExchangeRemoteDataSource dataSource = ref.watch(exchangeRemoteDataSourceProvider);
  return ExchangeRepositoryImpl(remoteDataSource: dataSource);
}

// ==================== Domain Layer (Use Cases) ====================

@riverpod
GetExchangeRateUseCase getExchangeRateUseCase(Ref ref) {
  final ExchangeRepository repository = ref.watch(exchangeRepositoryProvider);
  return GetExchangeRateUseCase(repository);
}

@riverpod
ValidateExchangeUseCase validateExchangeUseCase(Ref ref) {
  return const ValidateExchangeUseCase();
}

