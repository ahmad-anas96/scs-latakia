import 'dart:developer';

import 'package:scs_latakia_app/course/models/course_details_model.dart';
import 'package:scs_latakia_app/course/models/user_course_info_model.dart';
import 'package:scs_latakia_app/course/models/user_course_response_model.dart';
import 'package:scs_latakia_app/course/models/user_session_info_model.dart';
import 'package:scs_latakia_app/course/models/user_session_response_model.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:http/http.dart' as http;

class CourseService {
  static Future<CourseDetailsResponseModel?> getCourseInfo(String id) async {
    try {
      var response = await http.get(Uri.parse("$ROOT_API/course/$id"));
      if (response.statusCode == 200) {
        return CourseDetailsResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e, stacktrace) {
      log("$e $stacktrace");
      return null;
    }
  }

  static Future<UserCourseResponseModel?> registerInCourse(
      String? userId, String? courseId) async {
    try {
      var response = await http.post(Uri.parse("$ROOT_API/userCourse"), body: {
        "CourseId": courseId,
        "UserId": userId,
        "role": "student",
        "status": "new",
      });
      if (response.statusCode == 201) {
        return UserCourseResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e, stacktrace) {
      log("$e $stacktrace");
      return null;
    }
  }

  static Future<UserSessionResponseModel?> registerInSession(
      String? userId, String? sessionId) async {
    try {
      var response = await http.post(Uri.parse("$ROOT_API/userSession"),
          body: {"SessionId": sessionId, "UserId": userId});
      log("${response.statusCode}");
      if (response.statusCode == 201) {
        return UserSessionResponseModel.fromRawJson(response.body);
      } else {
        return null;
      }
    } catch (e, stacktrace) {
      log("$e $stacktrace");
      return null;
    }
  }
}
