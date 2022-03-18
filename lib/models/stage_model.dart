// To parse this JSON data, do
//
//     final stageModel = stageModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

StageModel stageModelFromJson(String str) =>
    StageModel.fromJson(json.decode(str));

String stageModelToJson(StageModel data) => json.encode(data.toJson());

class StageModel {
  StageModel({
    this.endDay,
    this.endMonth,
    this.endYear,
    this.stageDes,
    this.stageFunding,
    this.stageTitle,
    this.startDay,
    this.startMonth,
    this.startYear,
    this.uploadedProofImg,
    this.uploadedProofVideo,
    this.uploadedProofDoc,
    this.uploadedProofUrl,
    this.stageUid
  });

  String? endDay;
  String? endMonth;
  String? endYear;
  String? stageDes;
  String? stageFunding;
  String? stageTitle;
  String? startDay;
  String? startMonth;
  String? startYear;
  bool? uploadedProofImg;
  bool? uploadedProofVideo;
  bool? uploadedProofDoc;
  bool? uploadedProofUrl;
  String? stageUid;

  factory StageModel.fromJson(Map<String, dynamic> json) => StageModel(
        endDay: json["endDay"] == null ? null : json["endDay"],
        endMonth: json["endMonth"] == null ? null : json["endMonth"],
        endYear: json["endYear"] == null ? null : json["endYear"],
        stageDes: json["statusDes"] == null ? null : json["statusDes"],
        stageFunding:
            json["stageFunding"] == null ? null : json["stageFunding"],
        stageTitle: json["stageTitle"] == null ? null : json["stageTitle"],
        startDay: json["startDay"] == null ? null : json["startDay"],
        startMonth: json["startMonth"] == null ? null : json["startMonth"],
        startYear: json["startYear"] == null ? null : json["startYear"],
        uploadedProofImg:
            json["uploadedProofImg"] == null ? false : json["uploadedProofImg"],
        uploadedProofVideo: json["uploadedProofVideo"] == null
            ? false
            : json["uploadedProofVideo"],
        uploadedProofDoc:
            json["uploadedProofDoc"] == null ? false : json["uploadedProofDoc"],
        uploadedProofUrl:
            json["uploadedProofUrl"] == null ? false : json["uploadedProofUrl"],
         stageUid: json["stageUid"] == null ? null : json["stageUid"],
      );

  Map<String, dynamic> toJson() => {
        "endDay": endDay == null ? null : endDay,
        "endMonth": endMonth == null ? null : endMonth,
        "endYear": endYear == null ? null : endYear,
        "statusDes": stageDes == null ? null : stageDes,
        "stageFunding": stageFunding == null ? null : stageFunding,
        "stageTitle": stageTitle == null ? null : stageTitle,
        "startDay": startDay == null ? null : startDay,
        "startMonth": startMonth == null ? null : startMonth,
        "startYear": startYear == null ? null : startYear,
        "uploadedProofImg": uploadedProofImg == null ? null : uploadedProofImg,
        "uploadedProofVideo":
            uploadedProofVideo == null ? null : uploadedProofVideo,
        "uploadedProofDoc": uploadedProofDoc == null ? null : uploadedProofDoc,
        "uploadedProofUrl": uploadedProofUrl == null ? null : uploadedProofUrl,
        "stageUid": stageUid == null ? null : stageUid,
      };
}
