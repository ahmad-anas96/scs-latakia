import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/course/models/user_session_details.dart';
import 'package:scs_latakia_app/course/view_models/course_details_provider.dart';
import 'package:scs_latakia_app/course/views/course_user_item.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/validators.dart';

class UsersSessionList extends StatelessWidget {
  final SessionDetailsModel sessionDetails;
  const UsersSessionList({Key? key, required this.sessionDetails})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    CourseDetailsProvider? courseDetailsProvider =
        Provider.of<CourseDetailsProvider?>(context);

    List<UserCourseModel> _allStudents = courseDetailsProvider
            ?.courseDetailsResponseModel?.data.users
            .where((element) => element.userCourse.role == "student")
            .toList() ??
        [];

    _allStudents.sort((a, b) => b.name.compareTo(a.name));

    int i = courseDetailsProvider?.courseDetailsResponseModel?.data.sessions
            .indexWhere((element) => element.id == sessionDetails.id) ??
        -1;

    List<UserSessionModel> _studentsInSession = i == -1
        ? []
        : courseDetailsProvider
                ?.courseDetailsResponseModel?.data.sessions[i].users ??
            [];

    Map<UserCourseModel, UserSessionModel?> _usersSession = {};
    for (var student in _allStudents) {
      int i =
          _studentsInSession.indexWhere((element) => element.id == student.id);
      _usersSession[student] = i == -1 ? null : _studentsInSession[i];
    }

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      padding: const EdgeInsets.all(MAIN_MARGIN / 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${courseDetailsProvider?.course?.title}",
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 2,
            color: Theme.of(context).colorScheme.secondary,
            margin: const EdgeInsets.symmetric(vertical: MAIN_MARGIN / 4),
          ),
          Row(
            children: [
              Icon(
                Icons.today_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: MAIN_MARGIN / 2),
              Text(
                getDate(sessionDetails.dateTime),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          Row(
            children: [
              Icon(
                Icons.watch_later_rounded,
                color: Theme.of(context).colorScheme.secondary,
              ),
              const SizedBox(width: MAIN_MARGIN / 2),
              Text(
                getTime(sessionDetails.dateTime),
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(fontWeight: FontWeight.w600, fontSize: 16),
              ),
            ],
          ),
          const Divider(),
          ListView(
              shrinkWrap: true,
              children: _usersSession.keys.map((e) {
                return CourseUserWidget(
                  userCourseModel: e,
                  sessionDetails: sessionDetails,
                  userSessionModel: _usersSession[e],
                );
              }).toList()),
        ],
      ),
    );
  }
}
