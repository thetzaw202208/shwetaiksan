// To parse this JSON data, do
//
//     final registerVo = registerVoFromJson(jsonString);

import 'dart:convert';

RegisterVo registerVoFromJson(String str) => RegisterVo.fromJson(json.decode(str));

String registerVoToJson(RegisterVo data) => json.encode(data.toJson());

class RegisterVo {
  int? code;
  String? msg;
  Data? data;

  RegisterVo({
    this.code,
    this.msg,
    this.data,
  });

  factory RegisterVo.fromJson(Map<String, dynamic> json) => RegisterVo(
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
  String? name;
  String? phone;

  Data({
    this.name,
    this.phone,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
  };
}
