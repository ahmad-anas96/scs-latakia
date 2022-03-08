import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/course/models/user_course_info_model.dart';

class UserCourseModel extends UserModel {
  UserCourseModel(
    String id,
    String email,
    String role,
    String name,
    String? bio,
    String? linkedin,
    String? imagePath,
    String mobile,
    this.userCourse,
  ) : super(
            id: id,
            email: email,
            role: role,
            name: name,
            bio: bio,
            linkedin: linkedin,
            imagePath: imagePath,
            mobile: mobile);

  UserCourseInfoModel userCourse;

  factory UserCourseModel.fromJson(Map<String, dynamic> json) =>
      UserCourseModel(
        json["id"],
        json["email"],
        json["role"],
        json["name"],
        json["bio"],
        json["linkedin"],
        json["imagePath"],
        json["mobile"],
        UserCourseInfoModel.fromJson(
          json["UserCourse"],
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        "UserCourse": userCourse.toJson(),
      }..addAll(super.toJson());
}
