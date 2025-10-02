import 'package:flutter/material.dart';

enum CurrencyKind { crypto, fiat }

class CurrencyOption {
  const CurrencyOption({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.kind,
    this.assetPath,
  });

  final String id;
  final String code;
  final String name;
  final String description;
  final CurrencyKind kind;
  final String? assetPath;

  IconData get fallbackIcon =>
      kind == CurrencyKind.crypto ? Icons.currency_bitcoin : Icons.flag_circle;

  bool get hasAsset => assetPath != null && assetPath!.isNotEmpty;

  String get initials =>
      code.length >= 2 ? code.substring(0, 2).toUpperCase() : code.toUpperCase();
}
