import 'package:blockchain_utils/utils/numbers/rational/big_rational.dart';
import 'package:mrt_wallet/app/constant/global/rational.dart';

class PriceUtils {
  static BigInt? tryDecodePrice<T>(String price, int decimal) {
    try {
      return decodePrice(price, decimal);
    } catch (e) {
      return null;
    }
  }

  static BigInt convertPrice(
      {required String base, required String amount, required int decimal}) {
    final BigRational bPrice = BigRational.parseDecimal(base);
    final BigRational aPrice = BigRational.parseDecimal(amount);
    return decodePrice((bPrice * aPrice).toDecimal(), decimal,
        validateDecimal: false);
  }

  static BigInt decodePrice<T>(String price, int decimal,
      {bool validateDecimal = true}) {
    BigRational dec = BigRational.parseDecimal(price);
    dec = dec * RetionalConst.fromDecimalNumber(decimal);
    if (validateDecimal) {
      if (decimal == 0 && dec.isDecimal) {
        throw ArgumentError("price should not be decimal with decimal zero");
      }
    }
    return dec.toBigInt();
  }

  static String? tryEncodePrice(BigInt? price, int? decimal,
      {int amoutDecimal = 8}) {
    if (price == null || decimal == null) return null;
    try {
      return encodePrice(price, decimal);
    } catch (e) {
      return null;
    }
  }

  static String encodePrice(BigInt price, int decimal, {int amoutDecimal = 8}) {
    BigRational dec =
        BigRational(price) / RetionalConst.fromDecimalNumber(decimal);
    return dec.toDecimal(digits: amoutDecimal);
  }

  static String priceWithCoinName(String price, String coinAbbr) {
    return "$price $coinAbbr";
  }
}
