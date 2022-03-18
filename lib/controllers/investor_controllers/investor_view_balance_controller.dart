// ignore_for_file: deprecated_member_use

import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class InvestorViewBalanceController extends GetxController {
  String rpcUrl = "http://192.168.43.19:7545";
  String wsUrl = "ws://192.168.43.19:7545/";

  sendEther() async {
    print("Function Call for sending ether call");
    print("###################");
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    print(client);
    String privateKey =
        "50bb7f4362331617cb1fb4df3e66761b5a38fbb5e5127bb0962dc2cdd33e5562";

    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey);

    EthereumAddress ownAddress = await credentials.extractAddress();
    EtherAmount userBalance = await client.getBalance(ownAddress);
    print(userBalance.getInEther);
    EthereumAddress reciever =
        EthereumAddress.fromHex("0x84714D092E75EA7f4255eD93EE308d43b9aD1CDd");
    print("#################");
    print(ownAddress);

    String hashTx = await client.sendTransaction(
        credentials,
        Transaction(
            from: ownAddress,
            to: reciever,
            value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1)));
  }

  @override
  void onInit() {
    // TODO: implement onInit
    sendEther();
    super.onInit();
  }
}
