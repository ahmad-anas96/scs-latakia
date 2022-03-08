import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/models/user_model.dart';
import 'package:scs_latakia_app/course/models/session_model.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/course/models/user_session_info_model.dart';
import 'package:scs_latakia_app/course/services/course_service.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/utils/loading.dart';

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

  void registerInSession(BuildContext context, UserCourseModel user) {
    showDialog(
      context: context,
      builder: (_) => Loading(
        action: () async {
          var info = await CourseService.registerInSession(
            user.id,
            id,
          );
          if (info != null) {
            CourseDetailsProvider? courseDetailsProvider =
                Provider.of<CourseDetailsProvider?>(context, listen: false);
            int i = courseDetailsProvider
                    ?.courseDetailsResponseModel?.data.sessions
                    .indexWhere((element) => element.id == id) ??
                -1;

            courseDetailsProvider
                ?.courseDetailsResponseModel?.data.sessions[i].users
                .add(
              UserSessionModel(
                user.id,
                user.email,
                user.role,
                user.name,
                user.imagePath,
                user.mobile,
                info.data,
              ),
            );
            courseDetailsProvider?.notify();
          }
          Navigator.pop(context);
        },
      ),
    );
  }
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
