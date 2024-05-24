// To parse this JSON data, do
//
//     final photoUploadResponseVo = photoUploadResponseVoFromJson(jsonString);

import 'dart:convert';

PhotoUploadResponseVo photoUploadResponseVoFromJson(String str) => PhotoUploadResponseVo.fromJson(json.decode(str));

String photoUploadResponseVoToJson(PhotoUploadResponseVo data) => json.encode(data.toJson());

class PhotoUploadResponseVo {
  String? status;
  Results? results;

  PhotoUploadResponseVo({
    this.status,
    this.results,
  });

  factory PhotoUploadResponseVo.fromJson(Map<String, dynamic> json) => PhotoUploadResponseVo(
    status: json["status"],
    results: json["results"] == null ? null : Results.fromJson(json["results"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "results": results?.toJson(),
  };
}

class Results {
  List<String>? fileUpload;

  Results({
    this.fileUpload,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    fileUpload: json["fileUpload"] == null ? [] : List<String>.from(json["fileUpload"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "fileUpload": fileUpload == null ? [] : List<dynamic>.from(fileUpload!.map((x) => x)),
  };
}
