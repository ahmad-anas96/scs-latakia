import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:scs_latakia_app/my_courses/views/my_course_view.dart';
import 'package:scs_latakia_app/my_courses/view_models/my_courses_view_model.dart';
import 'package:scs_latakia_app/utils/const.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyCoursesListView extends StatelessWidget {
  const MyCoursesListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MyCoursesViewModel? coursesViewModel =
        Provider.of<MyCoursesViewModel?>(context);

    return Container(
      padding: const EdgeInsets.all(MAIN_MARGIN / 4),
      child: coursesViewModel?.loading == true
          ? SizedBox(
              height: 200,
              child: Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              ),
            )
          : (coursesViewModel?.courses.isEmpty ?? true)
              ? SizedBox(
                  height: 200,
                  child: Center(
                    child: Text(
                      "${AppLocalizations.of(context)?.noResults}",
                    ),
                  ),
                )
              : StaggeredGrid.count(
                  crossAxisCount: 1,
                  children: List.generate(
                    coursesViewModel?.courses.length ?? 0,
                    (index) => CourseViewList(
                      model: coursesViewModel!.courses[index],
                    ),
                  ),
                ),
    );
  }
}
