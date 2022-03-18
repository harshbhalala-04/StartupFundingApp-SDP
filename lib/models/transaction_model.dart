// To parse this JSON data, do
//
//     final transactionModel = transactionModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

TransactionModel transactionModelFromJson(String str) =>
    TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) =>
    json.encode(data.toJson());

class TransactionModel {
  TransactionModel({
    this.amount,
    this.from,
    this.to,
    this.stageId,
    this.txHash,
  });

  String? amount;
  String? from;
  String? to;
  String? stageId;
  String? txHash;

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        amount: json["amount"] == null ? null : json["amount"],
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null ? null : json["to"],
        stageId: json["stageId"] == null ? null : json["stageId"],
        txHash: json["txHash"] == null ? null : json["txHash"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount == null ? null : amount,
        "from": from == null ? null : from,
        "to": to == null ? null : to,
        "stageId": stageId == null ? null : stageId,
        "txHash": txHash == null ? null : txHash,
      };
}
