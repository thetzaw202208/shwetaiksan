// To parse this JSON data, do
//
//     final liveResultApiResponse = liveResultApiResponseFromJson(jsonString);

import 'dart:convert';

LiveResultApiResponse liveResultApiResponseFromJson(String str) => LiveResultApiResponse.fromJson(json.decode(str));

String liveResultApiResponseToJson(LiveResultApiResponse data) => json.encode(data.toJson());

class LiveResultApiResponse {
  DateTime? serverTime;
  Live? live;
  List<Result>? result;
  Holiday? holiday;

  LiveResultApiResponse({
    this.serverTime,
    this.live,
    this.result,
    this.holiday,
  });

  factory LiveResultApiResponse.fromJson(Map<String, dynamic> json) => LiveResultApiResponse(
    serverTime: json["server_time"] == null ? null : DateTime.parse(json["server_time"]),
    live: json["live"] == null ? null : Live.fromJson(json["live"]),
    result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    holiday: json["holiday"] == null ? null : Holiday.fromJson(json["holiday"]),
  );

  Map<String, dynamic> toJson() => {
    "server_time": serverTime?.toIso8601String(),
    "live": live?.toJson(),
    "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    "holiday": holiday?.toJson(),
  };
}

class Holiday {
  String? status;
  DateTime? date;
  String? name;

  Holiday({
    this.status,
    this.date,
    this.name,
  });

  factory Holiday.fromJson(Map<String, dynamic> json) => Holiday(
    status: json["status"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "name": name,
  };
}

class Live {
  String? liveSet;
  String? value;
  DateTime? time;
  String? twod;
  DateTime? date;

  Live({
    this.liveSet,
    this.value,
    this.time,
    this.twod,
    this.date,
  });

  factory Live.fromJson(Map<String, dynamic> json) => Live(
    liveSet: json["set"],
    value: json["value"],
    time: json["time"] == null ? null : DateTime.parse(json["time"]),
    twod: json["twod"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "set": liveSet,
    "value": value,
    "time": time?.toIso8601String(),
    "twod": twod,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}

class Result {
  String? resultSet;
  String? value;
  String? openTime;
  String? twod;
  DateTime? stockDate;
  DateTime? stockDatetime;
  String? historyId;

  Result({
    this.resultSet,
    this.value,
    this.openTime,
    this.twod,
    this.stockDate,
    this.stockDatetime,
    this.historyId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    resultSet: json["set"],
    value: json["value"],
    openTime: json["open_time"],
    twod: json["twod"],
    stockDate: json["stock_date"] == null ? null : DateTime.parse(json["stock_date"]),
    stockDatetime: json["stock_datetime"] == null ? null : DateTime.parse(json["stock_datetime"]),
    historyId: json["history_id"],
  );

  Map<String, dynamic> toJson() => {
    "set": resultSet,
    "value": value,
    "open_time": openTime,
    "twod": twod,
    "stock_date": "${stockDate!.year.toString().padLeft(4, '0')}-${stockDate!.month.toString().padLeft(2, '0')}-${stockDate!.day.toString().padLeft(2, '0')}",
    "stock_datetime": stockDatetime?.toIso8601String(),
    "history_id": historyId,
  };
}
