import 'dart:convert';

class UserCourseInfoModel {
  UserCourseInfoModel({
    required this.id,
    this.couponCode,
    this.certificate,
    required this.role,
    required this.status,
    required this.courseId,
    required this.userId,
  });

  String id;
  String? couponCode;
  String? certificate;
  String role;
  String status;
  String courseId;
  String userId;

  factory UserCourseInfoModel.fromRawJson(String str) =>
      UserCourseInfoModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserCourseInfoModel.fromJson(Map<String, dynamic> json) =>
      UserCourseInfoModel(
        id: json["id"],
        couponCode: json["couponCode"],
        certificate: json["certificate"],
        role: json["role"],
        status: json["status"],
        courseId: json["CourseId"],
        userId: json["UserId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "couponCode": couponCode,
        "certificate": certificate,
        "role": role,
        "status": status,
        "courseId": courseId,
        "UserId": userId,
      };
}
