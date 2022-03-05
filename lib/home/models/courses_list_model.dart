import 'dart:convert';

import 'package:scs_latakia_app/home/models/course_model.dart';

class CoursesListModel {
  CoursesListModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  int statusCode;
  List<CourseModel> data;
  String message;

  factory CoursesListModel.fromRawJson(String str) =>
      CoursesListModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CoursesListModel.fromJson(Map<String, dynamic> json) =>
      CoursesListModel(
        statusCode: json["statusCode"],
        data: List<CourseModel>.from(
            json["data"].map((x) => CourseModel.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}
