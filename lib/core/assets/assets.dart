/// Provides typed access to bundled asset paths.
class Assets {
  Assets._();

  static const String _base = 'assets';
  static const String _cryptoBase = '$_base/cripto_currencies';
  static const String _fiatBase = '$_base/fiat_currencies';

  /// Crypto assets.
  static const String tatumTronUsdt = '$_cryptoBase/TATUM-TRON-USDT.png';
  static const String tatumTronUsdc = '$_cryptoBase/TATUM-TRON-USDC.png';

  /// Fiat assets.
  static const String fiatBrl = '$_fiatBase/BRL.png';
  static const String fiatCop = '$_fiatBase/COP.png';
  static const String fiatPen = '$_fiatBase/PEN.png';
  static const String fiatVes = '$_fiatBase/VES.png';
  static const String fiatArs = '$_fiatBase/ARS.png';
  static const String fiatBob = '$_fiatBase/BOB.png';

  static List<String> get cryptoCurrencies =>
      List<String>.unmodifiable(<String>[tatumTronUsdt, tatumTronUsdc]);

  static List<String> get fiatCurrencies => List<String>.unmodifiable(
        <String>[fiatBrl, fiatCop, fiatPen, fiatVes, fiatArs, fiatBob],
      );
}
