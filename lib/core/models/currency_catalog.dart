import '../assets/assets.dart';
import 'currency_option.dart';

class CurrencyCatalog {
  CurrencyCatalog._();

  static final List<CurrencyOption> fiatOptions = <CurrencyOption>[
    const CurrencyOption(
      id: 'VES',
      code: 'VES',
      name: 'Bolívar venezolano',
      description: 'Bolívares (Bs)',
      kind: CurrencyKind.fiat,
      assetPath: Assets.fiatVes,
    ),
    const CurrencyOption(
      id: 'COP',
      code: 'COP',
      name: 'Peso colombiano',
      description: r'Pesos Colombianos (COL$)',
      kind: CurrencyKind.fiat,
      assetPath: Assets.fiatCop,
    ),
    const CurrencyOption(
      id: 'ARS',
      code: 'ARS',
      name: 'Peso argentino',
      description: r'Pesos Argentinos (ARS\$)',
      kind: CurrencyKind.fiat,
      assetPath: Assets.fiatArs,
    ),
    const CurrencyOption(
      id: 'PEN',
      code: 'PEN',
      name: 'Sol peruano',
      description: 'Soles Peruanos (S/)',
      kind: CurrencyKind.fiat,
      assetPath: Assets.fiatPen,
    ),
    const CurrencyOption(
      id: 'BRL',
      code: 'BRL',
      name: 'Real brasileño',
      description: r'Real Brasileño (R\$)',
      kind: CurrencyKind.fiat,
      assetPath: Assets.fiatBrl,
    ),
    const CurrencyOption(
      id: 'BOB',
      code: 'BOB',
      name: 'Boliviano',
      description: 'Boliviano (Bs)',
      kind: CurrencyKind.fiat,
      assetPath: Assets.fiatBob,
    ),
  ];

  static final List<CurrencyOption> cryptoOptions = <CurrencyOption>[
    const CurrencyOption(
      id: 'TATUM-TRON-USDT',
      code: 'USDT',
      name: 'Tether',
      description: 'Tether (USDT)',
      kind: CurrencyKind.crypto,
      assetPath: Assets.tatumTronUsdt,
    ),
    const CurrencyOption(
      id: 'TATUM-TRON-USDC',
      code: 'USDC',
      name: 'USD Coin',
      description: 'USD Coin (USDC)',
      kind: CurrencyKind.crypto,
      assetPath: Assets.tatumTronUsdc,
    ),
  ];
}
