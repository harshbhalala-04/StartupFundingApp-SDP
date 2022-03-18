// To parse this JSON data, do
//
//     final investorModel = investorModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

InvestorModel investorModelFromJson(String str) =>
    InvestorModel.fromJson(json.decode(str));

String investorModelToJson(InvestorModel data) => json.encode(data.toJson());

class InvestorModel {
  InvestorModel(
      {this.assets,
      this.category,
      this.cityName,
      this.email,
      this.experience,
      this.expertise,
      this.firstName,
      this.investedBefore,
      this.investorImg,
      this.lastName,
      this.linkedinUrl,
      this.mentorStartup,
      this.phoneNo,
      this.preferInvestment,
      this.uid,
      this.excludedStartup,
      this.accountAddress,
      this.accountProvided,
      this.notificationTokens});

  String? assets;
  String? category;
  String? cityName;
  String? email;
  List<String>? experience;
  List<String>? expertise;
  List<String>? notificationTokens;
  String? firstName;
  String? investedBefore;
  String? investorImg;
  String? lastName;
  String? linkedinUrl;
  String? mentorStartup;
  String? phoneNo;
  String? preferInvestment;
  String? uid;
  List<String>? excludedStartup;
  String? accountAddress;
  bool? accountProvided;

  factory InvestorModel.fromJson(Map<String, dynamic> json) => InvestorModel(
        assets: json["assets"] == null ? null : json["assets"],
        category: json["category"] == null ? null : json["category"],
        cityName: json["cityName"] == null ? null : json["cityName"],
        email: json["email"] == null ? null : json["email"],
        experience: json["experience"] == null
            ? null
            : List<String>.from(json["experience"].map((x) => x)),
        expertise: json["expertise"] == null
            ? null
            : List<String>.from(json["expertise"].map((x) => x)),
        notificationTokens: json["notificationTokens"] == null
            ? null
            : List<String>.from(json["notificationTokens"].map((x) => x)),
        excludedStartup: json["excludeStartup"] == null
            ? null
            : List<String>.from(json["excludeStartup"].map((x) => x)),
        firstName: json["firstName"] == null ? null : json["firstName"],
        investedBefore:
            json["investedBefore"] == null ? null : json["investedBefore"],
        investorImg: json["investorImg"] == null ? null : json["investorImg"],
        lastName: json["lastName"] == null ? null : json["lastName"],
        linkedinUrl: json["linkedinUrl"] == null ? null : json["linkedinUrl"],
        mentorStartup:
            json["mentorStartup"] == null ? null : json["mentorStartup"],
        phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
        preferInvestment:
            json["preferInvestment"] == null ? null : json["preferInvestment"],
        uid: json["uid"] == null ? null : json["uid"],
        accountAddress:
            json["accountAddress"] == null ? null : json["accountAddress"],
        accountProvided:
            json["accountProvided"] == null ? null : json["accountProvided"],
      );

  Map<String, dynamic> toJson() => {
        "assets": assets == null ? null : assets,
        "category": category == null ? null : category,
        "cityName": cityName == null ? null : cityName,
        "email": email == null ? null : email,
        "experience": experience == null
            ? null
            : List<dynamic>.from(experience!.map((x) => x)),
        "expertise": expertise == null
            ? null
            : List<dynamic>.from(expertise!.map((x) => x)),
        "notificationTokens": notificationTokens == null
            ? null
            : List<dynamic>.from(notificationTokens!.map((x) => x)),
        "excludeStartup": excludedStartup == null
            ? null
            : List<dynamic>.from(excludedStartup!.map((x) => x)),
        "firstName": firstName == null ? null : firstName,
        "investedBefore": investedBefore == null ? null : investedBefore,
        "investorImg": investorImg == null ? null : investorImg,
        "lastName": lastName == null ? null : lastName,
        "linkedinUrl": linkedinUrl == null ? null : linkedinUrl,
        "mentorStartup": mentorStartup == null ? null : mentorStartup,
        "phoneNo": phoneNo == null ? null : phoneNo,
        "preferInvestment": preferInvestment == null ? null : preferInvestment,
        "uid": uid == null ? null : uid,
        "accountAddress": accountAddress == null ? null : accountAddress,
        "accountProvided": accountProvided == null ? null : accountProvided,
      };
}
