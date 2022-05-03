// To parse this JSON data, do
//
//     final startupModel = startupModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

StartupModel startupModelFromJson(String str) =>
    StartupModel.fromJson(json.decode(str));

String startupModelToJson(StartupModel data) => json.encode(data.toJson());

class StartupModel {
  StartupModel(
      {this.coFounderImg,
      this.email,
      this.founderImg,
      this.linkedinUrl,
      this.phoneNo,
      this.pitchDeckUrl,
      this.regStartupName,
      this.secondFounderEmail,
      this.secondFounderLinkedinUrl,
      this.secondFounderName,
      this.singleUser,
      this.startupCategory,
      this.startupCity,
      this.startupDescription,
      this.startupLogoUrl,
      this.startupName,
      this.startupStage,
      this.userName,
      this.uid,
      this.excludeInvestor,
      this.accountAddress,
      this.accountProvided,
      this.notificationTokens,
      this.equity,
      this.valuation,
      this.raisedAmount});

  String? coFounderImg;
  String? email;
  String? founderImg;
  String? linkedinUrl;
  String? phoneNo;
  String? pitchDeckUrl;
  String? regStartupName;
  String? secondFounderEmail;
  String? secondFounderLinkedinUrl;
  String? secondFounderName;
  String? singleUser;
  String? startupCategory;
  String? startupCity;
  String? startupDescription;
  String? startupLogoUrl;
  String? startupName;
  String? startupStage;
  String? userName;
  String? uid;
  List<String>? excludeInvestor;
  List<String>? notificationTokens;
  String? accountAddress;
  bool? accountProvided;
  String? raisedAmount;
  String? equity;
  String? valuation;

  factory StartupModel.fromJson(Map<String, dynamic> json) => StartupModel(
      coFounderImg: json["coFounderImg"] == null ? null : json["coFounderImg"],
      email: json["email"] == null ? null : json["email"],
      founderImg: json["founderImg"] == null ? null : json["founderImg"],
      linkedinUrl: json["linkedinUrl"] == null ? null : json["linkedinUrl"],
      phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
      pitchDeckUrl: json["pitchDeckUrl"] == null ? null : json["pitchDeckUrl"],
      regStartupName:
          json["regStartupName"] == null ? null : json["regStartupName"],
      secondFounderEmail: json["secondFounderEmail"] == null
          ? null
          : json["secondFounderEmail"],
      secondFounderLinkedinUrl: json["secondFounderLinkedinUrl"] == null
          ? null
          : json["secondFounderLinkedinUrl"],
      secondFounderName:
          json["secondFounderName"] == null ? null : json["secondFounderName"],
      singleUser: json["singleUser"] == null ? null : json["singleUser"],
      startupCategory:
          json["startupCategory"] == null ? null : json["startupCategory"],
      startupCity: json["startupCity"] == null ? null : json["startupCity"],
      startupDescription: json["startupDescription"] == null
          ? null
          : json["startupDescription"],
      startupLogoUrl:
          json["startupLogoUrl"] == null ? null : json["startupLogoUrl"],
      startupName: json["startupName"] == null ? null : json["startupName"],
      startupStage: json["startupStage"] == null ? null : json["startupStage"],
      userName: json["userName"] == null ? null : json["userName"],
      uid: json["uid"] == null ? null : json["uid"],
      excludeInvestor: json["excludeInvestor"] == null
          ? null
          : List<String>.from(json["excludeInvestor"].map((x) => x)),
      notificationTokens: json["notificationTokens"] == null
          ? null
          : List<String>.from(json["notificationTokens"].map((x) => x)),
      accountAddress:
          json["accountAddress"] == null ? null : json["accountAddress"],
      accountProvided:
          json["accountProvided"] == null ? null : json["accountProvided"],
      equity: json["equity"] == null ? null : json["equity"],
      raisedAmount: json["raisedAmount"] == null ? null : json["raisedAmount"],
      valuation: json["valuation"] == null ? null : json["valuation"]);

  Map<String, dynamic> toJson() => {
        "coFounderImg": coFounderImg == null ? null : coFounderImg,
        "email": email == null ? null : email,
        "founderImg": founderImg == null ? null : founderImg,
        "linkedinUrl": linkedinUrl == null ? null : linkedinUrl,
        "phoneNo": phoneNo == null ? null : phoneNo,
        "pitchDeckUrl": pitchDeckUrl == null ? null : pitchDeckUrl,
        "regStartupName": regStartupName == null ? null : regStartupName,
        "secondFounderEmail":
            secondFounderEmail == null ? null : secondFounderEmail,
        "secondFounderLinkedinUrl":
            secondFounderLinkedinUrl == null ? null : secondFounderLinkedinUrl,
        "secondFounderName":
            secondFounderName == null ? null : secondFounderName,
        "singleUser": singleUser == null ? null : singleUser,
        "startupCategory": startupCategory == null ? null : startupCategory,
        "startupCity": startupCity == null ? null : startupCity,
        "startupDescription":
            startupDescription == null ? null : startupDescription,
        "startupLogoUrl": startupLogoUrl == null ? null : startupLogoUrl,
        "startupName": startupName == null ? null : startupName,
        "startupStage": startupStage == null ? null : startupStage,
        "userName": userName == null ? null : userName,
        "uid": uid == null ? null : uid,
        "accountAddress": accountAddress == null ? null : accountAddress,
        "accountProvided": accountProvided == null ? null : accountProvided,
        "equity": equity == null ? null : equity,
        "raisedAmount": raisedAmount == null ? null : raisedAmount,
        "valuation": valuation == null ? null : valuation,
        "excludeInvestor": excludeInvestor == null
            ? null
            : List<dynamic>.from(excludeInvestor!.map((x) => x)),
        "notificationTokens": notificationTokens == null
            ? null
            : List<dynamic>.from(notificationTokens!.map((x) => x)),
      };
}
