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
      this.stage});

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
  List<Stage>? stage;

  factory StartupModel.fromJson(Map<String, dynamic> json) => StartupModel(
        coFounderImg:
            json["coFounderImg"] == null ? null : json["coFounderImg"],
        email: json["email"] == null ? null : json["email"],
        founderImg: json["founderImg"] == null ? null : json["founderImg"],
        linkedinUrl: json["linkedinUrl"] == null ? null : json["linkedinUrl"],
        phoneNo: json["phoneNo"] == null ? null : json["phoneNo"],
        pitchDeckUrl:
            json["pitchDeckUrl"] == null ? null : json["pitchDeckUrl"],
        regStartupName:
            json["regStartupName"] == null ? null : json["regStartupName"],
        secondFounderEmail: json["secondFounderEmail"] == null
            ? null
            : json["secondFounderEmail"],
        secondFounderLinkedinUrl: json["secondFounderLinkedinUrl"] == null
            ? null
            : json["secondFounderLinkedinUrl"],
        secondFounderName: json["secondFounderName"] == null
            ? null
            : json["secondFounderName"],
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
        startupStage:
            json["startupStage"] == null ? null : json["startupStage"],
        userName: json["userName"] == null ? null : json["userName"],
        uid: json["uid"] == null ? null : json["uid"],
        excludeInvestor: json["excludeInvestor"] == null
            ? null
            : List<String>.from(json["excludeInvestor"].map((x) => x)),
        stage: json["Stage"] == null
            ? null
            : List<Stage>.from(json["Stage"].map((x) => Stage.fromJson(x))),
      );

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
        "excludeInvestor": excludeInvestor == null
            ? null
            : List<dynamic>.from(excludeInvestor!.map((x) => x)),
        "Stage": stage == null
            ? null
            : List<dynamic>.from(stage!.map((x) => x.toJson())),
      };
}

class Stage {
  Stage({
    this.startDay,
    this.startMonth,
    this.startYear,
    this.endDay,
    this.endMonth,
    this.endYear,
    this.stageTitle,
    this.stageDes,
    this.stageFunding,
  });

  String? startDay;
  String? startMonth;
  String? startYear;
  String? endDay;
  String? endMonth;
  String? endYear;
  String? stageTitle;
  String? stageDes;
  String? stageFunding;

  factory Stage.fromJson(Map<String, dynamic> json) => Stage(
        startDay: json["startDay"] == null ? null : json["startDay"],
        startMonth: json["startMonth"] == null ? null : json["startMonth"],
        startYear: json["startYear"] == null ? null : json["startYear"],
        endDay: json["endDay"] == null ? null : json["endDay"],
        endMonth: json["endMonth"] == null ? null : json["endMonth"],
        endYear: json["endYear"] == null ? null : json["endYear"],
        stageTitle: json["stageTitle"] == null ? null : json["stageTitle"],
        stageDes: json["stageDes"] == null ? null : json["stageDes"],
        stageFunding:
            json["stageFunding"] == null ? null : json["stageFunding"],
      );

  Map<String, dynamic> toJson() => {
        "startDay": startDay == null ? null : startDay,
        "startMonth": startMonth == null ? null : startMonth,
        "startYear": startYear == null ? null : startYear,
        "endDay": endDay == null ? null : endDay,
        "endMonth": endMonth == null ? null : endMonth,
        "endYear": endYear == null ? null : endYear,
        "stageTitle": stageTitle == null ? null : stageTitle,
        "stageDes": stageDes == null ? null : stageDes,
        "stageFunding": stageFunding == null ? null : stageFunding,
      };
}
