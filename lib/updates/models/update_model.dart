import 'dart:convert';

class UpdateModel {
  UpdateModel({
    this.versionCode,
    this.play,
    this.direct,
  });

  String? versionCode;
  String? play;
  String? direct;

  factory UpdateModel.fromRawJson(String str) =>
      UpdateModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateModel.fromJson(Map<String, dynamic> json) => UpdateModel(
        versionCode: json["versionCode"],
        play: json["play"],
        direct: json["direct"],
      );

  Map<String, dynamic> toJson() => {
        "versionCode": versionCode,
        "play": play,
        "direct": direct,
      };
}
