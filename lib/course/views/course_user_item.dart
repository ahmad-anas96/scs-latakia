import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/course/models/user_session_details.dart';
import 'package:scs_latakia_app/course/services/course_service.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:scs_latakia_app/utils/snack.dart';

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
                      .bodyText1
                      ?.copyWith(height: 1.3),
                ),
              ],
            ),
          ),
          Checkbox(
            value: userSessionModel != null,
            onChanged: (value) {
              if (value ?? false) {
                showDialog(
                  context: context,
                  builder: (_) => Loading(
                    action: () async {
                      var info = await CourseService.registerInSession(
                        userCourseModel.id,
                        sessionDetails.id,
                      );
                      if (info != null) {
                        CourseDetailsProvider? courseDetailsProvider =
                            Provider.of<CourseDetailsProvider?>(context,
                                listen: false);
                        int i = courseDetailsProvider
                                ?.courseDetailsResponseModel?.data.sessions
                                .indexWhere((element) =>
                                    element.id == sessionDetails.id) ??
                            -1;

                        courseDetailsProvider
                            ?.courseDetailsResponseModel?.data.sessions[i].users
                            .add(
                          UserSessionModel(
                            userCourseModel.id,
                            userCourseModel.email,
                            userCourseModel.role,
                            userCourseModel.name,
                            userCourseModel.imagePath,
                            userCourseModel.mobile,
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
            },
          ),
        ],
      ),
    );
  }
}
