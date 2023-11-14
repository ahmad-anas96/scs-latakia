// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/course/models/user_session_details.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';

class CourseUserWidget extends StatelessWidget {
  final UserCourseModel userCourseModel;
  final SessionDetailsModel sessionDetails;
  final UserSessionModel? userSessionModel;
  const CourseUserWidget({
    Key? key,
    required this.sessionDetails,
    required this.userCourseModel,
    this.userSessionModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: imageWithLoader(userCourseModel.imagePath, null),
          ),
          const SizedBox(width: MAIN_MARGIN / 2),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userCourseModel.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  userCourseModel.email,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(height: 1.3),
                ),
              ],
            ),
          ),
          Checkbox(
            value: userSessionModel != null,
            onChanged: (value) {
              if (value ?? false) {
                sessionDetails.registerInSession(context, userCourseModel);
              }
            },
          ),
        ],
      ),
    );
  }
}
