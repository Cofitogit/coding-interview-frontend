import 'package:dio/dio.dart';

import '../../../core/models/currency_option.dart';
import '../../../core/models/exchange_recommendation.dart';
import '../../../core/services/log_service.dart';
import '../../../core/services/net_service.dart';

/// Servicio encargado de las operaciones de red relacionadas con exchanges.
class ExchangeService {
  ExchangeService({NetService? netService}) : _netService = netService ?? NetService();

  final NetService _netService;

  /// Obtiene las recomendaciones de exchange desde el backend.
  Future<ExchangeRecommendationSummary?> fetchRecommendations({
    required int exchangeType,
    required CurrencyOption crypto,
    required CurrencyOption fiat,
    required String amount,
    required String amountCurrencyId,
  }) async {
    try {
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'type': exchangeType,
        'cryptoCurrencyId': crypto.id,
        'fiatCurrencyId': fiat.id,
        'amount': amount,
        'amountCurrencyId': amountCurrencyId,
      };

      final Response<dynamic> response = await _netService.get(
        '/orderbook/public/recommendations',
        queryParameters: queryParams,
      );

      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      final ExchangeRecommendations recommendations =
          ExchangeRecommendations.fromJson(responseData);
      
      return recommendations.toSummary();
    } catch (e, stackTrace) {
      logger.e('Error fetching exchange recommendations', error: e, stackTrace: stackTrace);
      rethrow;
    }
  }
}

