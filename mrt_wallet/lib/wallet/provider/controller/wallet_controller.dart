part of 'package:mrt_wallet/wallet/provider/wallet_provider.dart';

abstract class _WalletController with CryptoWokerImpl {
  _WalletController(this._walletCore, this._wallet, this._appChains);

  WalletCore? _walletCore;
  WalletCore get _core {
    if (_walletCore == null) {
      throw WalletExceptionConst.walletIsNotavailable;
    }
    return _walletCore!;
  }

  List<int>? _walletKey;
  EncryptedMasterKey? _massterKey;

  HDWallet _wallet;
  final ChainsHandler _appChains;
  Chain get chain => _appChains.chain;
  WalletNetwork get network => chain.network;

  late HDWalletStatus _status =
      _wallet.requiredPassword ? HDWalletStatus.lock : HDWalletStatus.readOnly;
  bool get isLock => _status == HDWalletStatus.lock;
  bool get isReadOnly => _status == HDWalletStatus.readOnly;
  bool get isUnlock => _status == HDWalletStatus.unlock;
  bool get isOpen => _status.isOpen;

  Future<void> _updateWallet(HDWallet wallet, {bool? asDefaultWallet}) async {
    if (wallet._checksum != _wallet._checksum) return;
    _wallet = wallet;
    await _core._updateWallet(_wallet, asDefaultWallet: asDefaultWallet);
  }
}

class WalletController extends _WalletController
    with
        WalletManager,
        Web3SolanaImpl,
        Web3EthereumImpl,
        Web3TronImpl,
        Web3TonImpl,
        Web3StellarImpl,
        Web3Impl {
  WalletController._(WalletCore core, HDWallet wallet, ChainsHandler chains)
      : super(core, wallet, chains);
  static Future<ChainsHandler> _setupNetwork(
      WalletCore core, HDWallet wallet) async {
    List<Chain> chains = [];
    print("传入数据14");
    final keys = await core._readAccounts(wallet);
    for (final i in keys) {
      try {
        final chain = Chain.deserialize(id: wallet._checksum, hex: i.$2);
        print("传入数据14:${chain.network.networkName}");
        chains.add(chain);
        // ignore: empty_catches
      } catch (e) {
        print("传入数据1:$e");
      }
    }
    print("传入数据15:${chains.length}");
    print("传入数据16:${wallet.network}");
    print("传入数据17:${wallet._checksum}");

    final chain = ChainsHandler(
        chains: chains, currentNetwork: wallet.network, id: wallet._checksum);
    print("传入数据18:${chain.network.networkName}");
    return chain;
  }

  static Future<WalletController> _setup(
      WalletCore core, HDWallet wallet) async {
    print("传入数据13:${wallet.name}");
    print("传入数据13:${wallet.network}");
    // print("传入数据13:${core.chain.network.networkName}");
    final chains = await _setupNetwork(core, wallet);
    print("传入数据12:${chains.network.networkName}");
    final controller = WalletController._(core, wallet, chains);
    controller.chain.initProvider();
    controller._streamBalances();
    return controller;
  }

  Future<void> _dispose() async {
    _walletCore = null;
    _walletKey = null;
    _massterKey = null;
    _timeout.dispose();
    _disposeBalanceUpdater();
  }
}
