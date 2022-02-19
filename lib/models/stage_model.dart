// To parse this JSON data, do
//
//     final stageModel = stageModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

StageModel stageModelFromJson(String str) => StageModel.fromJson(json.decode(str));

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

    factory StageModel.fromJson(Map<String, dynamic> json) => StageModel(
        endDay: json["endDay"] == null ? null : json["endDay"],
        endMonth: json["endMonth"] == null ? null : json["endMonth"],
        endYear: json["endYear"] == null ? null : json["endYear"],
        stageDes: json["stageDes"] == null ? null : json["stageDes"],
        stageFunding: json["stageFunding"] == null ? null : json["stageFunding"],
        stageTitle: json["stageTitle"] == null ? null : json["stageTitle"],
        startDay: json["startDay"] == null ? null : json["startDay"],
        startMonth: json["startMonth"] == null ? null : json["startMonth"],
        startYear: json["startYear"] == null ? null : json["startYear"],
    );

    Map<String, dynamic> toJson() => {
        "endDay": endDay == null ? null : endDay,
        "endMonth": endMonth == null ? null : endMonth,
        "endYear": endYear == null ? null : endYear,
        "stageDes": stageDes == null ? null : stageDes,
        "stageFunding": stageFunding == null ? null : stageFunding,
        "stageTitle": stageTitle == null ? null : stageTitle,
        "startDay": startDay == null ? null : startDay,
        "startMonth": startMonth == null ? null : startMonth,
        "startYear": startYear == null ? null : startYear,
    };
}
