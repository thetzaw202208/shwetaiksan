// To parse this JSON data, do
//
//     final twoResultApiResponse = twoResultApiResponseFromJson(jsonString);

import 'dart:convert';

List<TwoResultApiResponse> twoResultApiResponseFromJson(String str) => List<TwoResultApiResponse>.from(json.decode(str).map((x) => TwoResultApiResponse.fromJson(x)));

String twoResultApiResponseToJson(List<TwoResultApiResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TwoResultApiResponse {
  List<ResultData>? child;
  DateTime? date;

  TwoResultApiResponse({
    this.child,
    this.date,
  });

  factory TwoResultApiResponse.fromJson(Map<String, dynamic> json) => TwoResultApiResponse(
    child: json["child"] == null ? [] : List<ResultData>.from(json["child"]!.map((x) => ResultData.fromJson(x))),
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "child": child == null ? [] : List<dynamic>.from(child!.map((x) => x.toJson())),
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}

class ResultData {
  String? time;
  String? childSet;
  String? value;
  String? twod;
  String? historyId;

  ResultData({
    this.time,
    this.childSet,
    this.value,
    this.twod,
    this.historyId,
  });

  factory ResultData.fromJson(Map<String, dynamic> json) => ResultData(
    time: json["time"],
    childSet: json["set"],
    value: json["value"],
    twod: json["twod"],
    historyId: json["history_id"],
  );

  Map<String, dynamic> toJson() => {
    "time": time,
    "set": childSet,
    "value": value,
    "twod": twod,
    "history_id": historyId,
  };
}
