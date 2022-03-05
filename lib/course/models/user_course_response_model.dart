import 'dart:convert';

import 'package:scs_latakia_app/course/models/user_course_info_model.dart';

class UserCourseResponseModel {
  UserCourseResponseModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  int statusCode;
  String message;
  UserCourseInfoModel data;

  factory UserCourseResponseModel.fromRawJson(String str) =>
      UserCourseResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCourseResponseModel.fromJson(Map<String, dynamic> json) =>
      UserCourseResponseModel(
        statusCode: json["statusCode"],
        message: json["message"],
        data: UserCourseInfoModel.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "message": message,
        "data": data,
      };
}
