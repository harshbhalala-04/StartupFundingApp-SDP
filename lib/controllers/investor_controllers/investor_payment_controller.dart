// ignore_for_file: deprecated_member_use

import 'package:get/get.dart';
import 'package:startupfunding/controllers/investor_controllers/investor_global_controller.dart';
import 'package:startupfunding/database/investor_database.dart';
import 'package:startupfunding/global.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';
import 'package:http/http.dart';

import '../../screens/investors/investor_workstream/payment_confirm_screen.dart';

class InvestorPaymentController extends GetxController {
  final isLoading = false.obs;
  final privateKey = "".obs;
  final accountBalance = "".obs;
  final isAccAvailable = false.obs;

  final isPaymentProcess = false.obs;
  final transactionHash = "".obs;

  sendEther(String recieverAddress, String amount, String workStreamId,
      String stageId) async {
    isPaymentProcess.toggle();
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    String privateKey = this.privateKey.value;

    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey);

    EthereumAddress ownAddress = await credentials.extractAddress();
    EtherAmount userBalance = await client.getBalance(ownAddress);

    EthereumAddress reciever = EthereumAddress.fromHex(recieverAddress);
    print("IS loading value for tx: $isPaymentProcess");
    String hashTx = await client.sendTransaction(
        credentials,
        Transaction(
            from: ownAddress,
            to: reciever,
            value: EtherAmount.fromUnitAndValue(EtherUnit.ether, amount)));
    transactionHash.value = hashTx;
    isPaymentProcess.toggle();
   
    Get.off(PaymentConfirmScreen());
    InvestorDataBase().addPaymentInformation(ownAddress.toString(),
        reciever.toString(), amount, workStreamId, stageId, transactionHash.value);
  }

  getBalance() async {
    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey.value);

    EthereumAddress ownAddress = await credentials.extractAddress();
    print(ownAddress);
    print("%%%%%%%%%%%%%%%%%%%");
    EtherAmount userBalance = await client.getBalance(ownAddress);
    print("#####################");
    print(userBalance.getValueInUnit(EtherUnit.ether));
    accountBalance.value =
        userBalance.getValueInUnit(EtherUnit.ether).toString();
  }

  checkKey() async {
    isLoading.toggle();
    print(
        Get.find<InvestorGlobalController>().currentInvestor.accountProvided!);
    if (Get.find<InvestorGlobalController>().currentInvestor.accountProvided!) {
      privateKey.value =
          Get.find<InvestorGlobalController>().currentInvestor.accountAddress!;
      isAccAvailable.value = true;

      getBalance();
    }
    isLoading.toggle();
  }
}
