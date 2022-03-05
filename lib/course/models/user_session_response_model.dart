import 'dart:convert';

import 'package:scs_latakia_app/course/models/user_session_info_model.dart';

class UserSessionResponseModel {
  UserSessionResponseModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  int statusCode;
  String message;
  UserSessionInfoModel data;

  factory UserSessionResponseModel.fromRawJson(String str) =>
      UserSessionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserSessionResponseModel.fromJson(Map<String, dynamic> json) =>
      UserSessionResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: UserSessionInfoModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data,
      };
}
