// To parse this JSON data, do
//
//     final twoDOrderAmResponseVo = twoDOrderAmResponseVoFromJson(jsonString);

import 'dart:convert';

TwoDOrderAmResponseVo twoDOrderAmResponseVoFromJson(String str) => TwoDOrderAmResponseVo.fromJson(json.decode(str));

String twoDOrderAmResponseVoToJson(TwoDOrderAmResponseVo data) => json.encode(data.toJson());

class TwoDOrderAmResponseVo {
  int? code;
  String? msg;
  Data? data;

  TwoDOrderAmResponseVo({
    this.code,
    this.msg,
    this.data,
  });

  factory TwoDOrderAmResponseVo.fromJson(Map<String, dynamic> json) => TwoDOrderAmResponseVo(
    code: json["code"],
    msg: json["msg"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "msg": msg,
    "data": data?.toJson(),
  };
}

class Data {
  String? phone;
  DateTime? date;

  Data({
    this.phone,
    this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    phone: json["phone"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
  };
}
