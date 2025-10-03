import 'package:dio/dio.dart';
import '../../../../core/errors/exception_mapper.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/models/currency_option.dart';
import '../../../../core/models/exchange_recommendation.dart';
import '../../../../core/services/log_service.dart';
import '../../../../core/services/net_service.dart';
import '../models/exchange_rate_dto.dart';

/// Interface of the remote DataSource
abstract class ExchangeRemoteDataSource {
  Future<ExchangeRateDTO> getExchangeRate({
    required CurrencyOption from,
    required CurrencyOption to,
    required String amount,
  });
}

class ExchangeRemoteDataSourceImpl implements ExchangeRemoteDataSource {
  ExchangeRemoteDataSourceImpl({NetService? netService})
      : _netService = netService ?? NetService();

  final NetService _netService;

  @override
  Future<ExchangeRateDTO> getExchangeRate({
    required CurrencyOption from,
    required CurrencyOption to,
    required String amount,
  }) async {
    return ExceptionMapper.wrapDioCall(() async {
      //! Determine the type of exchange
      final int exchangeType = _determineExchangeType(from, to);
      final bool isCryptoToFiat = exchangeType == 0;

      //! Identify crypto and fiat
      final CurrencyOption crypto = from.kind == CurrencyKind.crypto ? from : to;
      final CurrencyOption fiat = from.kind == CurrencyKind.fiat ? from : to;

      //! Build query params
      final Map<String, dynamic> queryParams = <String, dynamic>{
        'type': exchangeType,
        'cryptoCurrencyId': crypto.id,
        'fiatCurrencyId': fiat.id,
        'amount': amount,
        'amountCurrencyId': from.id,
      };

      //! Call the API
      final Response<dynamic> response = await _netService.get(
        '/orderbook/public/recommendations',
        queryParameters: queryParams,
      );

      //! Parse the response
      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      final ExchangeRecommendations recommendations = ExchangeRecommendations.fromJson(responseData);
      final ExchangeRecommendationSummary? summary = recommendations.toSummary();

      if (summary == null) {
        logger.w('No offers available for exchange: ${from.id} -> ${to.id}');
        throw const NoOffersAvailableException(
          technicalDetails: 'API returned empty recommendations',
        );
      }

      //! Convert to DTO with correct limits based on exchange direction
      return ExchangeRateDTO.fromApiModel(summary, isCryptoToFiat: isCryptoToFiat);
    });
  }

  //! Determine the type of exchange: 0 (crypto->fiat) or 1 (fiat->crypto)
  int _determineExchangeType(CurrencyOption from, CurrencyOption to) {
    if (from.kind == CurrencyKind.crypto && to.kind == CurrencyKind.fiat) {
      return 0;
    }
    return 1;
  }
}

