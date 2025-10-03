import '../../domain/entities/exchange_rate_entity.dart';
import '../../../../core/models/exchange_recommendation.dart';

/// DTO for transferring data from the API to the domain entity.
/// Converts ExchangeRecommendationSummary (API) -> ExchangeRateEntity (Domain)
class ExchangeRateDTO {
  const ExchangeRateDTO({
    required this.rate,
    required this.estimatedMinutes,
    this.minLimit,
    this.maxLimit,
  });

  factory ExchangeRateDTO.fromApiModel(
    ExchangeRecommendationSummary summary, {
    required bool isCryptoToFiat,
  }) {
    final CurrencyLimits? limits = summary.limitsForExchange(isCryptoToFiat: isCryptoToFiat);
    
    return ExchangeRateDTO(
      rate: summary.fiatToCryptoRate,
      estimatedMinutes: summary.estimatedMinutes ?? 0.0,
      minLimit: limits?.minLimit,
      maxLimit: limits?.maxLimit,
    );
  }

  final double rate;
  final double estimatedMinutes;
  final double? minLimit;
  final double? maxLimit;

  ExchangeRateEntity toEntity() {
    return ExchangeRateEntity(
      rate: rate,
      estimatedMinutes: estimatedMinutes,
      minLimit: minLimit,
      maxLimit: maxLimit,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRateDTO &&
          runtimeType == other.runtimeType &&
          rate == other.rate &&
          estimatedMinutes == other.estimatedMinutes &&
          minLimit == other.minLimit &&
          maxLimit == other.maxLimit;

  @override
  int get hashCode =>
      rate.hashCode ^
      estimatedMinutes.hashCode ^
      minLimit.hashCode ^
      maxLimit.hashCode;
}

