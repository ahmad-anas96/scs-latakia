import 'package:flutter/material.dart';
import 'package:scs_latakia_app/course/models/user_course_details.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:scs_latakia_app/utils/loading.dart';
import 'package:url_launcher/url_launcher.dart';

class CourseCoachWidget extends StatelessWidget {
  final UserCourseModel model;
  const CourseCoachWidget({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            height: 50,
            width: 50,
            child: imageWithLoader(model.imagePath, null),
          ),
          const SizedBox(width: MAIN_MARGIN / 2),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  model.name,
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "${model.bio}",
                  style: Theme.of(context)
                      .textTheme
                      .bodyText2
                      ?.copyWith(height: 1.3),
                ),
              ],
            ),
          ),
          if (model.linkedin != null)
            IconButton(
              onPressed: () {
                launch("${model.linkedin}");
              },
              icon: Image.asset(
                "assets/images/linkedin.png",
                height: 25,
                width: 25,
              ),
            ),
        ],
      ),
    );
  }
}
