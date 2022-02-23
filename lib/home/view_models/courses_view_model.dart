import 'package:flutter/material.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';

class CoursesViewModel extends ChangeNotifier {
  List<CourseModel>? _courses = [];
  String? _search;
  String? _selectedTag;

  String? get search => _search;

  set search(String? value) {
    _search = value;
    notifyListeners();
  }

  String? get selectedTag => _selectedTag;

  set selectedTag(String? value) {
    _selectedTag = value;
    notifyListeners();
  }

  bool isTagSelected(String tag) => tag == _selectedTag;

  List<CourseModel> get courses {
    List<CourseModel> temp = _courses
            ?.where((element) =>
                element.title.toLowerCase().contains(_search ?? ''))
            .toList() ??
        [];

    return temp;
  }

  set courses(List<CourseModel>? value) {
    _courses = value;
    notifyListeners();
  }

  List<String> getTags() {
    Set<String> tags = {};
    for (CourseModel item in _courses ?? []) {
      tags.addAll(item.tags.split(','));
    }
    return tags.toList();
  }
}
