import 'dart:convert';

import 'package:scs_latakia_app/course/models/user_session_details.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';

class CourseDetailsResponseModel {
  CourseDetailsResponseModel({
    required this.statusCode,
    required this.data,
    required this.message,
  });

  int statusCode;
  CourseDetailsModel data;
  String message;

  factory CourseDetailsResponseModel.fromRawJson(String str) => CourseDetailsResponseModel.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory CourseDetailsResponseModel.fromJson(Map<String, dynamic> json) => CourseDetailsResponseModel(
        statusCode: json["statusCode"],
        data: CourseDetailsModel.fromJson(json["data"]),
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "statusCode": statusCode,
        "data": data.toJson(),
        "message": message,
    };
}

class CourseDetailsModel {
  CourseDetailsModel({
    required this.id,
    required this.sessions,
    required this.users,
  });

  String id;
  List<SessionDetailsModel> sessions;
  List<UserCourseModel> users;

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      CourseDetailsModel(
        id: json["id"],
        sessions: List<SessionDetailsModel>.from(
            json["Sessions"].map((x) => SessionDetailsModel.fromJson(x))),
        users: List<UserCourseModel>.from(
            json["Users"].map((x) => UserCourseModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Sessions": List<dynamic>.from(sessions.map((x) => x.toJson())),
        "Users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}
