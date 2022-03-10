import 'package:flutter/material.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:scs_latakia_app/home/models/courses_list_model.dart';
import 'package:scs_latakia_app/utils/const.dart';

class MyCoursesViewModel extends ChangeNotifier {
  bool _loading = true;
  List<CourseModel> _courses = [];

  MyCoursesViewModel() {
    reload();
  }

  bool get loading => _loading;

  List<CourseModel> get courses => _courses;

  Future<void> reload() async {
    try {
      var response = await http.get(Uri.parse(
          "$ROOT_API/userCourse?UserId=${AuthProvider.loginData?.user.id}"));
      if (response.statusCode == 200) {
        _courses = CoursesListModel.fromRawJson(response.body).data;
      }
      _loading = false;
    } catch (e) {
      _loading = false;
    }
    notifyListeners();
  }
}
