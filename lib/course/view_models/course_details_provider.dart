import 'package:flutter/material.dart';

import 'package:scs_latakia_app/course/models/course_details_model.dart';
import 'package:scs_latakia_app/course/services/course_service.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';

class CourseDetailsProvider extends ChangeNotifier {
  CourseModel? _course;
  bool _loading = true;
  CourseDetailsResponseModel? _courseDetailsResponseModel;

  CourseDetailsResponseModel? get courseDetailsResponseModel =>
      _courseDetailsResponseModel;

  set courseDetailsResponseModel(CourseDetailsResponseModel? value) {
    _courseDetailsResponseModel = value;
    notifyListeners();
  }

  CourseModel? get course => _course;

  set course(CourseModel? value) {
    _course = value;
    notifyListeners();
    loadData();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  Future<void> loadData() async {
    loading = true;
    var info = await CourseService.getCourseInfo(course?.id ?? '');
    if (info != null) {
      courseDetailsResponseModel = info;
    }
    loading = false;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
