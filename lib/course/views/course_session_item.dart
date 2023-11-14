// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/auth/view_models/auth_provider.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/course/models/user_session_details.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/course/views/users_session_list.dart';
import 'package:scs_latakia_app/utils/validators.dart';

class CourseSessionWidget extends StatelessWidget {
  final SessionDetailsModel model;
  const CourseSessionWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? myId = AuthProvider.loginData?.user.id;
    bool coachOrMentor = false;

    CourseDetailsProvider? courseDetailsProvider =
        Provider.of<CourseDetailsProvider?>(context);
    List<UserCourseModel> _users =
        courseDetailsProvider?.courseDetailsResponseModel?.data.users ?? [];

    for (var user in _users) {
      if (user.id == myId &&
          (user.userCourse.role == "admin" ||
              user.userCourse.role == "coach")) {
        coachOrMentor = true;
        break;
      } else {
        coachOrMentor = false;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  formatDateTime(model.dateTime),
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "${model.summary}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(height: 1.3),
                ),
              ],
            ),
          ),
          if (coachOrMentor)
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => UsersSessionList(sessionDetails: model),
                );
              },
              icon: Icon(
                Icons.arrow_forward_ios_rounded,
                color: Theme.of(context).primaryColor,
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}
