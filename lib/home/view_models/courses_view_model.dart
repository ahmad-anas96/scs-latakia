import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:scs_latakia_app/home/models/course_model.dart';
import 'package:http/http.dart' as http;
import 'package:scs_latakia_app/home/models/courses_list_model.dart';
import 'package:scs_latakia_app/utils/const.dart';

class CoursesViewModel extends ChangeNotifier {
  bool _loading = true;
  List<CourseModel>? _courses = [];
  String? _search;
  String? _selectedTag;

  CoursesViewModel() {
    reload();
  }

  bool get loading => _loading;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

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

  bool isTagSelected(String tag) => tag.trim() == _selectedTag?.trim();

  List<CourseModel> get courses =>
      _courses
          ?.where((element) =>
              element.title
                  .toLowerCase()
                  .contains(_search?.toLowerCase() ?? '') &&
              element.tags.contains(_selectedTag ?? ''))
          .toList() ??
      [];

  List<String> getTags() {
    Set<String> tags = {};
    for (CourseModel item in _courses ?? []) {
      tags.addAll(item.tags.split(','));
    }
    return List.generate(
        tags.toList().length, (index) => tags.toList()[index].trim());
  }

  Future<void> reload() async {
    try {
      var response = await http.get(Uri.parse("$ROOT_API/course"));
      if (response.statusCode == 200) {
        _courses = CoursesListModel.fromRawJson(response.body).data;
      }
      _loading = false;
    } catch (e) {
      log("$e");
      _loading = false;
    }
    notifyListeners();
  }
}
