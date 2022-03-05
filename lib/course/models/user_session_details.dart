import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/course/models/session_model.dart';
import 'package:scs_latakia_app/course/models/user_session_info_model.dart';

class SessionDetailsModel extends SessionModel {
  SessionDetailsModel(
    String id,
    String? summary,
    DateTime dateTime,
    String courseId,
    this.users,
  ) : super(id: id, courseId: courseId, summary: summary, dateTime: dateTime);

  List<UserSessionModel> users;

  factory SessionDetailsModel.fromJson(Map<String, dynamic> json) =>
      SessionDetailsModel(
        json["id"],
        json["summary"],
        DateTime.parse(json["dateTime"]),
        json["CourseId"],
        List<UserSessionModel>.from(
          json["Users"].map(
            (x) => UserSessionModel.fromJson(x),
          ),
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        "Users": List<dynamic>.from(users.map((x) => x.toJson())),
      }..addAll(super.toJson());
}

class UserSessionModel extends UserModel {
  UserSessionModel(
    String id,
    String email,
    String role,
    String name,
    String? imagePath,
    String mobile,
    this.userSession,
  ) : super(
            id: id,
            email: email,
            role: role,
            name: name,
            imagePath: imagePath,
            mobile: mobile);

  UserSessionInfoModel userSession;

  factory UserSessionModel.fromJson(Map<String, dynamic> json) =>
      UserSessionModel(
        json["id"],
        json["email"],
        json["role"],
        json["name"],
        json["imagePath"],
        json["mobile"],
        UserSessionInfoModel.fromJson(
          json["UserSession"],
        ),
      );

  @override
  Map<String, dynamic> toJson() => {
        "UserSession": userSession.toJson(),
      }..addAll(super.toJson());
}
