import 'dart:math';

part 'exchange_recommendation_utils.dart';

/// Models and utilities for exchange recommendations.
///
/// This file parses the complete response from the recommendations endpoint
/// and exposes a lightweight abstraction for consumption in the presentation layer.
/// Internal helpers reside in `exchange_recommendation_utils.dart`.

/// Recommendation types exposed by the endpoint (best price, speed or reputation).
enum ExchangeOfferKind { byPrice, bySpeed, byReputation }

extension ExchangeOfferKindKey on ExchangeOfferKind {
  String get apiKey {
    switch (this) {
      case ExchangeOfferKind.byPrice:
        return 'byPrice';
      case ExchangeOfferKind.bySpeed:
        return 'bySpeed';
      case ExchangeOfferKind.byReputation:
        return 'byReputation';
    }
  }
}

/// Numeric limits associated with a currency within an offer.
class CurrencyLimits {
  const CurrencyLimits({
    required this.minLimit,
    required this.maxLimit,
    this.marketSize,
    this.availableSize,
  });

  factory CurrencyLimits.fromJson(Map<String, dynamic> json) {
    return CurrencyLimits(
      minLimit: _asDouble(json['minLimit']) ?? 0.0,
      maxLimit: _asDouble(json['maxLimit']) ?? 0.0,
      marketSize: _asDouble(json['marketSize']),
      availableSize: _asDouble(json['availableSize']),
    );
  }

  /// Minimum limit allowed for the operation.
  final double minLimit;

  /// Maximum limit allowed for the operation.
  final double maxLimit;

  /// Total market size in the corresponding currency.
  final double? marketSize;

  /// Currently available size for trading.
  final double? availableSize;

  /// Returns `true` if `value` is within the defined limits.
  bool contains(double value) {
    if (minLimit > 0 && value < minLimit) {
      return false;
    }
    if (maxLimit > 0 && value > maxLimit) {
      return false;
    }
    return true;
  }
}

/// Summarized information of the user who publishes the offer.
class ExchangeOfferUser {
  const ExchangeOfferUser({
    required this.id,
    required this.username,
  });

  factory ExchangeOfferUser.fromJson(Map<String, dynamic> json) {
    return ExchangeOfferUser(
      id: json['id'] as String? ?? '',
      username: json['username'] as String? ?? '',
    );
  }

  /// Unique user identifier.
  final String id;

  /// Visible username.
  final String username;
}

/// Historical metrics of the merchant who generates the offer.
class OfferMakerStats {
  const OfferMakerStats({
    this.rating,
    this.userRating,
    this.releaseTime,
    this.payTime,
    this.responseTime,
    this.marketMakerOrderTime,
    this.marketMakerSuccessRatio,
    this.totalOffersCount,
    this.totalTransactionCount,
  });

  factory OfferMakerStats.fromJson(Map<String, dynamic> json) {
    return OfferMakerStats(
      rating: _asDouble(json['rating']),
      userRating: _asDouble(json['userRating']),
      releaseTime: _asDouble(json['releaseTime']),
      payTime: _asDouble(json['payTime']),
      responseTime: _asDouble(json['responseTime']),
      marketMakerOrderTime: _asDouble(json['marketMakerOrderTime']),
      marketMakerSuccessRatio: _asDouble(json['marketMakerSuccessRatio']),
      totalOffersCount: _asInt(json['totalOffersCount']),
      totalTransactionCount: _asInt(json['totalTransactionCount']),
    );
  }

  /// Average merchant rating.
  final double? rating;

  /// Rating given by users who traded with the merchant.
  final double? userRating;

  /// Average fund release time in minutes.
  final double? releaseTime;

  /// Average payment time in minutes.
  final double? payTime;

  /// Average response time in minutes.
  final double? responseTime;

  /// Median time to complete orders as a market maker.
  final double? marketMakerOrderTime;

  /// Success ratio as a market maker.
  final double? marketMakerSuccessRatio;

  /// Total number of created offers.
  final int? totalOffersCount;

  /// Total number of completed transactions.
  final int? totalTransactionCount;

  /// Estimated time in minutes to complete an order.
  double? get estimatedMinutes => marketMakerOrderTime;
}

/// Represents an exchange offer returned by the backend.
class ExchangeOffer {
  const ExchangeOffer({
    required this.kind,
    required this.offerId,
    required this.fiatToCryptoRate,
    required this.cryptoToFiatRate,
    this.description,
    this.fiatCurrencyId,
    this.cryptoCurrencyId,
    this.chain,
    this.offerStatus,
    this.offerType,
    this.createdAt,
    this.fiatLimits,
    this.cryptoLimits,
    this.paymentMethods = const <String>[],
    this.allowsThirdPartyPayments = false,
    this.paused = false,
    this.display = false,
    this.orderRequestEnabled = false,
    this.offerTransactionsEnabled = false,
    this.escrow,
    this.userStatus,
    this.userLastSeen,
    this.usdRate,
    this.user,
    this.makerStats,
  });

  factory ExchangeOffer.fromJson({
    required Map<String, dynamic> json,
    required ExchangeOfferKind kind,
  }) {
    final double fiatRate = _asDouble(json['fiatToCryptoExchangeRate']) ?? 0.0;
    final double cryptoRate = fiatRate > 0 ? 1 / fiatRate : 0.0;

    final Map<String, dynamic>? limitsJson =
        json['limits'] as Map<String, dynamic>?;

    CurrencyLimits? fiatLimits;
    CurrencyLimits? cryptoLimits;

    if (limitsJson != null && limitsJson.isNotEmpty) {
      final Map<String, dynamic>? fiatJson =
          limitsJson['fiat'] as Map<String, dynamic>?;
      final Map<String, dynamic>? cryptoJson =
          limitsJson['crypto'] as Map<String, dynamic>?;

      if (fiatJson != null) {
        fiatLimits = CurrencyLimits.fromJson(fiatJson);
      }

      if (cryptoJson != null) {
        cryptoLimits = CurrencyLimits.fromJson(cryptoJson);
      }
    }

    final Map<String, dynamic>? statsJson =
        json['offerMakerStats'] as Map<String, dynamic>?;

    final OfferMakerStats? makerStats =
        statsJson != null ? OfferMakerStats.fromJson(statsJson) : null;

    final Map<String, dynamic>? userJson =
        json['user'] as Map<String, dynamic>?;

    final ExchangeOfferUser? user =
        userJson != null ? ExchangeOfferUser.fromJson(userJson) : null;

    DateTime? createdAt;
    final String? createdAtRaw = json['createdAt'] as String?;
    if (createdAtRaw != null) {
      createdAt = DateTime.tryParse(createdAtRaw);
    }

    final List<String> paymentMethods = <String>[
      for (final dynamic method in (json['paymentMethods'] as List<dynamic>? ??
          const <dynamic>[]))
        if (method is String) method,
    ];

    return ExchangeOffer(
      kind: kind,
      offerId: json['offerId'] as String? ?? '',
      fiatToCryptoRate: fiatRate,
      cryptoToFiatRate: cryptoRate,
      description: json['description'] as String?,
      fiatCurrencyId: json['fiatCurrencyId'] as String?,
      cryptoCurrencyId: json['cryptoCurrencyId'] as String?,
      chain: json['chain'] as String?,
      offerStatus: _asInt(json['offerStatus']),
      offerType: _asInt(json['offerType']),
      createdAt: createdAt,
      fiatLimits: fiatLimits,
      cryptoLimits: cryptoLimits,
      paymentMethods: List<String>.unmodifiable(paymentMethods),
      allowsThirdPartyPayments: json['allowsThirdPartyPayments'] == true,
      paused: json['paused'] == true,
      display: json['display'] == true,
      orderRequestEnabled: json['orderRequestEnabled'] == true,
      offerTransactionsEnabled: json['offerTransactionsEnabled'] == true,
      escrow: json['escrow'] as String?,
      userStatus: json['user_status'] as String?,
      userLastSeen: json['user_lastSeen']?.toString(),
      usdRate: _asDouble(json['usdRate']),
      user: user,
      makerStats: makerStats,
    );
  }

  final ExchangeOfferKind kind;

  final String offerId;

  final double fiatToCryptoRate;

  final double cryptoToFiatRate;

  final String? description;

  final String? fiatCurrencyId;

  final String? cryptoCurrencyId;

  final String? chain;

  final int? offerStatus;

  final int? offerType;

  final DateTime? createdAt;

  final CurrencyLimits? fiatLimits;

  final CurrencyLimits? cryptoLimits;

  final List<String> paymentMethods;

  final bool allowsThirdPartyPayments;

  final bool paused;

  final bool display;

  final bool orderRequestEnabled;

  final bool offerTransactionsEnabled;

  final String? escrow;

  final String? userStatus;

  final String? userLastSeen;

  final double? usdRate;

  final ExchangeOfferUser? user;

  final OfferMakerStats? makerStats;

  bool get hasValidRate => fiatToCryptoRate > 0;

  double? get marketMakerOrderTimeMinutes =>
      makerStats?.estimatedMinutes;

  CurrencyLimits? limitsForExchange({required bool isCryptoToFiat}) {
    return isCryptoToFiat ? cryptoLimits : fiatLimits;
  }
}

/// Collection of offers returned by the recommendations endpoint.
class ExchangeRecommendations {
  const ExchangeRecommendations({
    required this.offers,
  });

  factory ExchangeRecommendations.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic>? data =
        json['data'] as Map<String, dynamic>?;

    if (data == null || data.isEmpty) {
      return const ExchangeRecommendations(offers: <ExchangeOffer>[]);
    }

    final List<ExchangeOffer> offers = <ExchangeOffer>[];

    for (final ExchangeOfferKind kind in ExchangeOfferKind.values) {
      final Map<String, dynamic>? offerJson =
          data[kind.apiKey] as Map<String, dynamic>?;

      if (offerJson != null && offerJson.isNotEmpty) {
        offers.add(
          ExchangeOffer.fromJson(json: offerJson, kind: kind),
        );
      }
    }

    return ExchangeRecommendations(
      offers: List<ExchangeOffer>.unmodifiable(offers),
    );
  }

  final List<ExchangeOffer> offers;

  bool get hasOffers => offers.isNotEmpty;

  ExchangeOffer? findByKind(ExchangeOfferKind kind) {
    for (final ExchangeOffer offer in offers) {
      if (offer.kind == kind) {
        return offer;
      }
    }
    return null;
  }

  /// Returns the primary offer, prioritizing `byPrice` and then the first one with a valid rate.
  ExchangeOffer? get primaryOffer {
    final ExchangeOffer? preferred =
        findByKind(ExchangeOfferKind.byPrice);

    if (preferred != null && preferred.hasValidRate) {
      return preferred;
    }

    for (final ExchangeOffer offer in offers) {
      if (offer.hasValidRate) {
        return offer;
      }
    }

    return preferred ?? (offers.isNotEmpty ? offers.first : null);
  }

  /// Average time in minutes calculated across all available offers.
  double? get averageOrderTimeMinutes {
    final List<double> values = <double>[
      for (final ExchangeOffer offer in offers)
        if (offer.marketMakerOrderTimeMinutes != null &&
            offer.marketMakerOrderTimeMinutes! > 0)
          offer.marketMakerOrderTimeMinutes!,
    ];

    if (values.isEmpty) {
      return null;
    }

    final double total = values.fold<double>(
      0,
      (double previousValue, double element) => previousValue + element,
    );

    return total / values.length;
  }

  /// Generates a UI-ready summary.
  ExchangeRecommendationSummary? toSummary({
    ExchangeOfferKind preferredKind = ExchangeOfferKind.byPrice,
  }) {
    ExchangeOffer? primary = findByKind(preferredKind);

    if (primary == null || !primary.hasValidRate) {
      primary = primaryOffer;
    }

    if (primary == null || !primary.hasValidRate) {
      return null;
    }

    return ExchangeRecommendationSummary(
      primaryOffer: primary,
      offers: offers,
      averageOrderTimeMinutes: averageOrderTimeMinutes,
    );
  }
}

/// Lightweight abstraction for the UI with ready-to-display values.
class ExchangeRecommendationSummary {
  ExchangeRecommendationSummary({
    required this.primaryOffer,
    required List<ExchangeOffer> offers,
    required this.averageOrderTimeMinutes,
  })  : offers = List<ExchangeOffer>.unmodifiable(offers);

  /// Candidate offer that will be used to display the main values.
  final ExchangeOffer primaryOffer;

  /// Complete list of offers received in the recommendation.
  final List<ExchangeOffer> offers;

  /// Average time in minutes considering all valid offers.
  final double? averageOrderTimeMinutes;

  /// Fiat -> crypto rate of the primary offer.
  double get fiatToCryptoRate => primaryOffer.fiatToCryptoRate;

  /// Crypto -> fiat rate of the primary offer.
  double get cryptoToFiatRate => primaryOffer.cryptoToFiatRate;

  /// Fiat limits available in the primary offer.
  CurrencyLimits? get fiatLimits => primaryOffer.fiatLimits;

  /// Crypto limits available in the primary offer.
  CurrencyLimits? get cryptoLimits => primaryOffer.cryptoLimits;

  /// Estimated time in minutes prioritizing the average across offers.
  double? get estimatedMinutes =>
      averageOrderTimeMinutes ?? primaryOffer.marketMakerOrderTimeMinutes;

  /// Searches for an offer by kind within the summary.
  ExchangeOffer? offerForKind(ExchangeOfferKind kind) {
    for (final ExchangeOffer offer in offers) {
      if (offer.kind == kind) {
        return offer;
      }
    }
    return null;
  }

  /// Returns the relevant limits based on the operation type.
  CurrencyLimits? limitsForExchange({required bool isCryptoToFiat}) {
    return primaryOffer.limitsForExchange(
      isCryptoToFiat: isCryptoToFiat,
    );
  }

  /// Calculates how much the user will receive based on the operation type.
  double calculateReceiveAmount({
    required double amount,
    required bool isCryptoToFiat,
  }) {
    if (amount <= 0) {
      return 0;
    }

    final double rate = fiatToCryptoRate;

    if (rate <= 0) {
      return 0;
    }

    return isCryptoToFiat ? amount * rate : amount / rate;
  }

  /// Returns the formatted estimated time ready for UI.
  String formatEstimatedMinutes({
    int decimals = 1,
    String placeholder = '--',
  }) {
    final double? minutes = estimatedMinutes;

    if (minutes == null ||
        minutes.isNaN ||
        minutes.isInfinite ||
        minutes < 0) {
      return placeholder;
    }

    final double safeValue = max(0, minutes);
    return safeValue.toStringAsFixed(decimals);
  }
}
