import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../core/models/currency_catalog.dart';
import '../../../core/models/currency_option.dart';
import '../../../core/models/exchange_recommendation.dart';
import '../../../core/providers/base_provider.dart';
import '../../../core/services/log_service.dart';
import '../../../core/services/net_service.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/widgets/currency_selector_sheet.dart';

class ExchangeProvider extends BaseProvider {
  ExchangeProvider({NetService? netService}) : _netService = netService ?? NetService() {
    _init();
  }

  static final List<CurrencyOption> _cryptoOptions =
      List<CurrencyOption>.unmodifiable(CurrencyCatalog.cryptoOptions);

  static final List<CurrencyOption> _fiatOptions =
      List<CurrencyOption>.unmodifiable(CurrencyCatalog.fiatOptions);

  final NetService _netService;

  CurrencyOption? _from;
  CurrencyOption? _to;
  String _amount = '';
  bool _isExecuting = false;
  ExchangeRecommendationSummary? _recommendation;
  String? _error;

  List<CurrencyOption> get cryptoOptions => _cryptoOptions;
  List<CurrencyOption> get fiatOptions => _fiatOptions;

  CurrencyOption? get from => _from;
  CurrencyOption? get to => _to;
  String get amount => _amount;
  bool get isExecuting => _isExecuting;
  ExchangeRecommendationSummary? get recommendation => _recommendation;

  String? get error => _error;

  double get amountValue => double.tryParse(_amount) ?? 0.0;

  /// Fiat -> crypto rate of the primary offer.
  double get estimatedRate {
    return _recommendation?.fiatToCryptoRate ?? 0.0;
  }

  double get receiveAmount {
    if (_recommendation == null || amountValue == 0) {
      return 0.0;
    }

    return _recommendation!.calculateReceiveAmount(
      amount: amountValue,
      isCryptoToFiat: exchangeType == 0,
    );
  }

  /// Formatted estimated time ready for UI.
  String get estimatedTimeFormatted {
    return _recommendation?.formatEstimatedMinutes(decimals: 1) ?? '--';
  }

  /// Raw estimated time (in minutes).
  double? get estimatedMinutes => _recommendation?.estimatedMinutes;

  /// Minimum limit allowed according to the active recommendation.
  double? get minLimit {
    final CurrencyLimits? limits =
        _recommendation?.limitsForExchange(isCryptoToFiat: exchangeType == 0);
    return limits?.minLimit;
  }

  /// Maximum limit allowed according to the active recommendation.
  double? get maxLimit {
    final CurrencyLimits? limits =
        _recommendation?.limitsForExchange(isCryptoToFiat: exchangeType == 0);
    return limits?.maxLimit;
  }

  int get exchangeType {
    if (_from == null || _to == null) {
      return 0;
    }
    if (_from!.kind == CurrencyKind.crypto && _to!.kind == CurrencyKind.fiat) {
      return 0;
    }
    return 1;
  }

  void _init() {
    _from = cryptoOptions.first;
    _to = fiatOptions.first;
    markInitialized();
  }

  void selectFrom(CurrencyOption option) {
    _from = option;
    _recommendation = null;
    _error = null;
    notifyListeners();
  }

  void selectTo(CurrencyOption option) {
    _to = option;
    _recommendation = null;
    _error = null;
    notifyListeners();
  }

  void swap() {
    final CurrencyOption? previousFrom = _from;
    _from = _to;
    _to = previousFrom;
    _recommendation = null;
    _error = null;
    notifyListeners();
  }

  void updateAmount(String value) {
    _amount = value;
    _recommendation = null;
    _error = null;
    notifyListeners();
  }

  /// TODO: In the future, all data fetching (REST API, local SQLite, Firestore, etc.)
  /// should be consumed from a dedicated service layer (e.g., home/services/)
  /// instead of directly from the provider. This will improve testability,
  /// maintainability, and allow for better separation of concerns.
  Future<void> execute() async {
    if (_isExecuting || _amount.isEmpty || _from == null || _to == null) {
      return;
    }

    _isExecuting = true;
    _error = null;
    notifyListeners();

    try {
      final CurrencyOption crypto = _from!.kind == CurrencyKind.crypto ? _from! : _to!;
      final CurrencyOption fiat = _from!.kind == CurrencyKind.fiat ? _from! : _to!;

      final Map<String, dynamic> queryParams = <String, dynamic>{
        'type': exchangeType,
        'cryptoCurrencyId': crypto.id,
        'fiatCurrencyId': fiat.id,
        'amount': _amount,
        'amountCurrencyId': _from!.id,
      };

      final Response<dynamic> response = await _netService.get(
        '/orderbook/public/recommendations',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      final ExchangeRecommendations recommendations =
          ExchangeRecommendations.fromJson(responseData);
      final ExchangeRecommendationSummary? summary = recommendations.toSummary();

      if (summary == null || !summary.primaryOffer.hasValidRate) {
        _error = 'No offers available for this operation';
        _recommendation = null;
      } else {
        final double amount = amountValue;
        final bool isCryptoToFiat = exchangeType == 0;

        // Determine which limits to use based on the operation type
        final CurrencyLimits? relevantLimits =
            summary.limitsForExchange(isCryptoToFiat: isCryptoToFiat);

        if (relevantLimits != null) {
          if (amount < relevantLimits.minLimit) {
            final String currency = _from?.code ?? '';
            _error = 'Monto mínimo: ${relevantLimits.minLimit.toStringAsFixed(2)} $currency';
            _recommendation = summary; // Guardar para mostrar límites
          } else if (amount > relevantLimits.maxLimit) {
            final String currency = _from?.code ?? '';
            _error = 'Monto máximo: ${relevantLimits.maxLimit.toStringAsFixed(2)} $currency';
            _recommendation = summary; // Guardar para mostrar límites
          } else {
            _recommendation = summary;
            _error = null;
          }
        } else {
          _recommendation = summary;
          _error = null;
        }
      }
    } catch (e, stackTrace) {
      _error = 'Error al obtener la tasa de cambio';
      _recommendation = null;
      logger.e('Error processing exchange recommendation', error: e, stackTrace: stackTrace);
    } finally {
      _isExecuting = false;
      notifyListeners();
    }
  }

  Future<void> openSelector(BuildContext context, {required bool isFrom}) async {
    final CurrencyOption? current = isFrom ? _from : _to;
    final CurrencyKind kind = current?.kind ?? (isFrom ? CurrencyKind.crypto : CurrencyKind.fiat);
    final List<CurrencyOption> source =
        kind == CurrencyKind.crypto ? cryptoOptions : fiatOptions;

    await showModalBottomSheet<void>(
      context: context,
      backgroundColor: AppColors.cardBackground,
      builder: (BuildContext context) {
        return CurrencySelectorSheet(
          options: source,
          activeId: current?.id,
          title: kind == CurrencyKind.crypto ? 'Cripto' : 'Fiat',
          onSelected: (CurrencyOption option) {
            if (isFrom) {
              selectFrom(option);
            } else {
              selectTo(option);
            }
          },
        );
      },
    );
  }
}
