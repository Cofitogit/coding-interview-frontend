/// class for exchange rate entity
class ExchangeRateEntity {
  const ExchangeRateEntity({required this.rate, required this.estimatedMinutes, this.minLimit, this.maxLimit});

  /// fiat -> crypto rate
  final double rate;

  /// estimated minutes
  final double estimatedMinutes;

  /// minimum limit for the operation
  final double? minLimit;

  /// maximum limit for the operation
  final double? maxLimit;

  double calculateReceiveAmount({required double amount, required bool isCryptoToFiat}) {
    if (amount <= 0 || rate <= 0) {
      return 0.0;
    }
    return isCryptoToFiat ? amount * rate : amount / rate;
  }

  bool isAmountValid(double amount) {
    if (minLimit != null && amount < minLimit!) {
      return false;
    }
    if (maxLimit != null && amount > maxLimit!) {
      return false;
    }
    return true;
  }

  String formatEstimatedMinutes({int decimals = 1}) {
    return estimatedMinutes.toStringAsFixed(decimals);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExchangeRateEntity &&
          runtimeType == other.runtimeType &&
          rate == other.rate &&
          estimatedMinutes == other.estimatedMinutes &&
          minLimit == other.minLimit &&
          maxLimit == other.maxLimit;

  @override
  int get hashCode => rate.hashCode ^ estimatedMinutes.hashCode ^ minLimit.hashCode ^ maxLimit.hashCode;

  @override
  String toString() =>
      'ExchangeRateEntity(rate: $rate, estimatedMinutes: $estimatedMinutes, minLimit: $minLimit, maxLimit: $maxLimit)';
}
