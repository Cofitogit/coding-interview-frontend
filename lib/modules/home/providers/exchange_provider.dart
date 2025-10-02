import '../../../core/models/currency_catalog.dart';
import '../../../core/models/currency_option.dart';
import '../../../core/models/exchange_recommendation.dart';
import '../../../core/providers/base_provider.dart';
import '../helpers/exchange_calculator.dart';
import '../helpers/exchange_validator.dart';
import '../models/exchange_state.dart';
import '../services/exchange_service.dart';
class ExchangeProvider extends BaseProvider {
  ExchangeProvider({ExchangeService? exchangeService}) : _exchangeService = exchangeService ?? ExchangeService() {
    _init();
  }

  final ExchangeService _exchangeService;

  // ==================== Currency Catalog ====================

  static final List<CurrencyOption> cryptoOptions = List<CurrencyOption>.unmodifiable(CurrencyCatalog.cryptoOptions);

  static final List<CurrencyOption> fiatOptions = List<CurrencyOption>.unmodifiable(CurrencyCatalog.fiatOptions);

  // ==================== State ====================

  ExchangeState _exchangeState = ExchangeState(from: cryptoOptions.first, to: fiatOptions.first);

  /// Current exchange state.
  ExchangeState get exchangeState => _exchangeState;

  // ==================== Convenience Getters ====================
  // Only expose the state, without heavy computations

  CurrencyOption? get from => _exchangeState.from;
  CurrencyOption? get to => _exchangeState.to;
  String get amount => _exchangeState.amount;
  bool get isExecuting => _exchangeState.isExecuting;
  String? get error => _exchangeState.error;

  // ==================== Initialization ====================

  void _init() {
    markInitialized();
  }

  // ==================== Actions ====================

  /// Selects the origin currency.
  void selectFrom(CurrencyOption option) {
    _updateState(_exchangeState.copyWith(from: option).clearRecommendation());
  }

  /// Selects the destination currency.
  void selectTo(CurrencyOption option) {
    _updateState(_exchangeState.copyWith(to: option).clearRecommendation());
  }

  /// Swaps the origin and destination currencies.
  void swap() {
    _updateState(_exchangeState.copyWith(from: _exchangeState.to, to: _exchangeState.from).clearRecommendation());
  }

  /// Updates the amount to exchange.
  void updateAmount(String value) {
    _updateState(_exchangeState.copyWith(amount: value).clearRecommendation());
  }

  Future<void> execute() async {
    if (!_exchangeState.canExecute) {
      return;
    }

    _updateState(_exchangeState.copyWith(isExecuting: true, clearError: true));

    try {
      final int exchangeType = ExchangeCalculator.determineExchangeType(
        from: _exchangeState.from,
        to: _exchangeState.to,
      );

      final CurrencyOption crypto = _exchangeState.from!.kind == CurrencyKind.crypto
          ? _exchangeState.from!
          : _exchangeState.to!;
      final CurrencyOption fiat = _exchangeState.from!.kind == CurrencyKind.fiat
          ? _exchangeState.from!
          : _exchangeState.to!;

      final ExchangeRecommendationSummary? summary = await _exchangeService.fetchRecommendations(
        exchangeType: exchangeType,
        crypto: crypto,
        fiat: fiat,
        amount: _exchangeState.amount,
        amountCurrencyId: _exchangeState.from!.id,
      );

      final ExchangeValidationResult validation = ExchangeValidator.validateAmount(
        amount: _exchangeState.amountValue,
        recommendation: summary,
        isCryptoToFiat: exchangeType == 0,
        fromCurrency: _exchangeState.from,
      );

      _updateState(
        _exchangeState.copyWith(
          isExecuting: false,
          recommendation: summary,
          error: validation.error,
          clearError: validation.isValid,
        ),
      );
    } catch (e) {
      _updateState(
        _exchangeState.copyWith(
          isExecuting: false,
          error: 'Error al obtener la tasa de cambio',
          clearRecommendation: true,
        ),
      );
    }
  }

  // ==================== Private ====================

  void _updateState(ExchangeState newState) {
    _exchangeState = newState;
    notifyListeners();
  }
}
