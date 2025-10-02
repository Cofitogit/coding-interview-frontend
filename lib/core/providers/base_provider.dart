import 'package:flutter/foundation.dart';

import '../services/log_service.dart';

/// Common lifecycle states shared by all providers.
enum ProviderState { loading, initialized, disposed }

/// Base class that centralizes provider lifecycle tracking and logging.
abstract class BaseProvider extends ChangeNotifier {
  BaseProvider() {
    logger.i('Provider created → $runtimeType');
  }

  ProviderState _state = ProviderState.loading;

  ProviderState get state => _state;

  bool get isDisposed => _state == ProviderState.disposed;

  bool get isLoading => _state == ProviderState.loading;

  bool get isInitialized => _state == ProviderState.initialized;

  @protected
  void markLoading() {
    _updateState(ProviderState.loading);
  }

  @protected
  void markInitialized() {
    _updateState(ProviderState.initialized);
  }

  @protected
  void markDisposed() {
    _updateState(ProviderState.disposed);
  }

  void _updateState(ProviderState next) {
    if (_state == next) {
      return;
    }
    _state = next;
    logger.d('Provider state → $runtimeType :: $next');
    notifyListeners();
  }

  @override
  void dispose() {
    if (!isDisposed) {
      markDisposed();
    }
    logger.i('Provider disposed → $runtimeType');
    super.dispose();
  }
}
