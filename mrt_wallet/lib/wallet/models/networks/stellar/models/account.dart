import 'package:mrt_wallet/app/utils/utils.dart';
import 'package:mrt_wallet/wallet/constant/networks/stellar.dart';
import 'package:mrt_wallet/wallet/models/token/chains_tokens/stellar_issue.dart';
import 'package:mrt_wallet/wallet/models/token/token/token.dart';
import 'package:stellar_dart/stellar_dart.dart';

extension StellarAccountResponseUtils on StellarAccountResponse {
  List<StellarAssetBalanceResponse> get issueAssetBalances =>
      balances.whereType<StellarAssetBalanceResponse>().toList();
  List<StellarNativeBalanceResponse> get nativeAssetBalancess =>
      balances.whereType<StellarNativeBalanceResponse>().toList();
  BigInt get nativeBalance =>
      nativeAssetBalancess.fold(BigInt.zero, (p, c) => p + c.unlockedBalance);

  StellarAssetBalanceResponse? getAsset(StellarAsset asset) {
    assert(asset.type == AssetType.creditAlphanum4 ||
        asset.type == AssetType.creditAlphanum12);
    if (asset.type == AssetType.creditAlphanum4) {
      final assetCode4 = asset.cast<StellarAssetCreditAlphanum4>();
      return issueAssetBalances.firstWhereOrNull((e) =>
          e.assetType.assetType == asset.type &&
          e.assetCode == assetCode4.code);
    }
    if (asset.type == AssetType.creditAlphanum12) {
      final assetCode4 = asset.cast<StellarAssetCreditAlphanum12>();
      return issueAssetBalances.firstWhereOrNull((e) =>
          e.assetType.assetType == asset.type &&
          e.assetCode == assetCode4.code);
    }
    return null;
  }

  StellarAssetBalanceResponse? getAssetByIssueAsset(StellarIssueToken asset) {
    return issueAssetBalances.firstWhereOrNull((e) =>
        e.assetType.assetType == asset.assetType &&
        e.assetCode == asset.token.symbol &&
        asset.issuer == e.assetIssuer);
  }
}

extension StellarAssetBalanceResponseUtils on StellarAssetBalanceResponse {
  StellarIssueToken toIssueToken() {
    return StellarIssueToken.create(
      issuer: assetIssuer,
      balance: unlockedBalance,
      assetType: assetType.assetType,
      token: Token(
          name: assetCode, symbol: assetCode, decimal: StellarConst.decimal),
    );
  }
}
