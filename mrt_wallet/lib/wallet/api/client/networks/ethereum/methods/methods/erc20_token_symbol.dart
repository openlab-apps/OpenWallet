import 'package:blockchain_utils/blockchain_utils.dart';
import 'package:mrt_wallet/crypto/utils/solidity/solidity.dart';
import 'package:on_chain/on_chain.dart';
import 'package:on_chain/solidity/address/core.dart';

class RPCERC20Symbol extends ETHRPCRequest<String?> {
  RPCERC20Symbol(this.contractAddress, {BlockTagOrNumber? blockNumber})
      : super(blockNumber: blockNumber ?? BlockTagOrNumber.pending);

  @override
  EthereumMethods get method => EthereumMethods.call;

  final SolidityAddress contractAddress;

  final AbiFunctionFragment _function = SolidityContractUtils.erc20Symbol;

  @override
  String? onResonse(result) {
    if (result == "0x") return null;
    final decode = _function.decodeOutputHex(result);
    if (decode.isEmpty) return null;
    return decode.first;
  }

  @override
  List<dynamic> toJson() {
    return [
      {
        "to": contractAddress.toHex(),
        "data": BytesUtils.toHexString(_function.encode([]), prefix: "0x"),
      },
      blockNumber
    ];
  }
}
