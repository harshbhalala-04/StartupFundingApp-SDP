// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

import 'package:get/get.dart';
import 'package:startupfunding/global.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class InvestorViewBalanceController extends GetxController {
  String privateKey = "";
  final accountBalance = "".obs;
  final isLoading = false.obs;
  final isAccAddressAvailable = false.obs;

  checkAccountAddress() async {
    isLoading.toggle();
    await FirebaseFirestore.instance
        .collection("Investors")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      print("Here check in database");
      print(value.data()?['accountAddress']);
      if (value.data()!.containsKey("accountAddress")) {
        isAccAddressAvailable.value = true;
        privateKey = value.data()!['accountAddress'];
      }
    });

    isLoading.toggle();
    print(isAccAddressAvailable);
    if (isAccAddressAvailable.value) {
      getBalance();
    }
  }

  getBalance() async {
    isLoading.toggle();

    Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });

    Credentials credentials =
        await client.credentialsFromPrivateKey(privateKey);

    EthereumAddress ownAddress = await credentials.extractAddress();
    EtherAmount userBalance = await client.getBalance(ownAddress);
    print("#####################");
    print(userBalance.getValueInUnit(EtherUnit.ether));
    accountBalance.value =
        userBalance.getValueInUnit(EtherUnit.ether).toString();
    isAccAddressAvailable.value = true;

    isLoading.toggle();
  }

  // sendEther() async {
  //   Web3Client client = Web3Client(rpcUrl, Client(), socketConnector: () {
  //     return IOWebSocketChannel.connect(wsUrl).cast<String>();
  //   });

  //   String privateKey =
  //       "dc7a8ca71ba7c2483bbc1a1e721d125ef170f651c2021863ecbc358943320fbe";

  //   Credentials credentials =
  //       await client.credentialsFromPrivateKey(privateKey);

  //   EthereumAddress ownAddress = await credentials.extractAddress();
  //   EtherAmount userBalance = await client.getBalance(ownAddress);

  //   EthereumAddress reciever =
  //       EthereumAddress.fromHex("0x097F3dDfF7d0081504C8c80e5E224dE6E50147B7");

  // String hashTx = await client.sendTransaction(
  //     credentials,
  //     Transaction(
  //         from: ownAddress,
  //         to: reciever,
  //         value: EtherAmount.fromUnitAndValue(EtherUnit.ether, 1)));
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    checkAccountAddress();

    super.onInit();
  }
}
