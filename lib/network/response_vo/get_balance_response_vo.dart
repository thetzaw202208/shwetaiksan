// To parse this JSON data, do
//
//     final registerVo = registerVoFromJson(jsonString);

import 'dart:convert';

GetBalanceResponseVo getBalanceVoFromJson(String str) => GetBalanceResponseVo.fromJson(json.decode(str));

String registerVoToJson(GetBalanceResponseVo data) => json.encode(data.toJson());

class GetBalanceResponseVo {
  int? code;
  String? msg;
  Data? data;

  GetBalanceResponseVo({
    this.code,
    this.msg,
    this.data,
  });

  factory GetBalanceResponseVo.fromJson(Map<String, dynamic> json) => GetBalanceResponseVo(
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
  String? balance;
  String? phone;

  Data({
    this.balance,
    this.phone,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    balance: json["balance"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "phone": phone,
  };
}
