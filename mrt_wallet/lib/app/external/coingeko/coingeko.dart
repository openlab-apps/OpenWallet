import 'package:mrt_wallet/app/models/models/image.dart';

class CoinGeckoUtils {
  //修改处
  // static const String _coingeckoPublicCurrenciesAPI =
  //     "https://api.coingecko.com/api/v3/simple/price?ids=#ids&vs_currencies=#currencies";
  static const String _coingeckoPublicCurrenciesAPI =
      "https://www.openverse.network/api/coinprice/getLatest/?ids=#ids&vs_currencies=#currencies";
  static const String coinGeckoCoinURL =
      "https://www.coingecko.com/en/coins/#id";
  static const String coinGeckoCoinListURL =
      "https://api.coingecko.com/api/v3/coins/list";
  static final APPImage logo = APPImage.local("assets/image/coingeko.png");
  static String? getTokenCoinGeckoURL(String id) {
    return coinGeckoCoinURL.replaceFirst("#id", id);
  }

  static String toCoingeckoPriceUri(String currencies, String ids) {
    return _coingeckoPublicCurrenciesAPI
        .replaceFirst("#currencies", currencies)
        .replaceFirst("#ids", ids);
  }
}
