part of 'package:mrt_wallet/wallet/provider/wallet_provider.dart';

mixin Web3StellarImpl on WalletManager {
  _getWalletOwnerResult(Web3Request request);
  Future<dynamic> _getStellarWeb3Result(Web3StellarRequest request) async {
    switch (request.params.method) {
      default:
        return await _getWalletOwnerResult(request);
    }
  }
}
