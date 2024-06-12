// To parse this JSON data, do
//
//     final historyResponseVo = historyResponseVoFromJson(jsonString);

import 'dart:convert';

HistoryResponseVo historyResponseVoFromJson(String str) => HistoryResponseVo.fromJson(json.decode(str));

String historyResponseVoToJson(HistoryResponseVo data) => json.encode(data.toJson());

class HistoryResponseVo {
  int? code;
  String? msg;
  List<HistoryData>? data;

  HistoryResponseVo({
    this.code,
    this.msg,
    this.data,
  });

  factory HistoryResponseVo.fromJson(Map<String, dynamic> json) => HistoryResponseVo(
    code: json["code"],
    msg: json["msg"],
    data: json["data"] == null ? [] : List<HistoryData>.from(json["data"]!.map((x) => HistoryData.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class HistoryData {
  String? phone;
  int? number;
  int? amount;
  DateTime? date;
  String? type;
  int? isIncome;

  HistoryData({
    this.phone,
    this.number,
    this.amount,
    this.date,
    this.type,
    this.isIncome,
  });

  factory HistoryData.fromJson(Map<String, dynamic> json) => HistoryData(
    phone: json["phone"],
    number: json["number"],
    amount: json["amount"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    type: json["type"],
    isIncome: json["isIncome"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "number": number,
    "amount": amount,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "type": type,
    "isIncome": isIncome,
  };
}
