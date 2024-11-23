import 'package:blockchain_utils/utils/utils.dart';
import 'package:stellar_dart/stellar_dart.dart';

class StellarConst {
  static const int decimal = 7;
  static const int memoTextMaxLength = 28;
  static const int stellarBase32SecretKeyLength = 56;
  static const int newAccountReserveStroopMultiply = 2;
  static const int stellarPubkeyHintLength = 4;
  static final BigInt maxFee = BigInt.from(maxUint32);
  static final BigInt maxIssueAmount = maxInt64;
  static final BigRational maxIssueAmountRational = BigRational(maxIssueAmount);
  static const Duration maxmimumTimeBound = Duration(days: 21);
  static const Duration defaultTimeBound = Duration(minutes: 1);
  static const mainnetPassphrase =
      "Public Global Stellar Network ; September 2015";
  static const List<OperationType> supportedOperations = [
    OperationType.payment,
    OperationType.changeTrust,
    OperationType.pathPaymentStrictReceive,
    OperationType.pathPaymentStrictSend,
    OperationType.createAccount,
    OperationType.manageSellOffer,
    OperationType.manageBuyOffer,
  ];
}
